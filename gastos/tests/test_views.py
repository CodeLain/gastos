from django.test import TestCase
from django.urls import reverse
from django.contrib.auth import get_user_model
from ..models import Gasto, Categoria

User = get_user_model()


class GastoListViewTests(TestCase):
    def setUp(self):
        # Create a test user
        self.user = User.objects.create_user(username='fede2', password='hola1234')

        # Create some categories and gastos
        self.cat1 = Categoria.objects.create(nombre='Transporte')
        self.cat2 = Categoria.objects.create(nombre='Alimentación')

        self.gasto1 = Gasto.objects.create(
            categoria=self.cat1,
            monto=50.00,
            fecha='2025-06-01',
            descripcion='Taxi al trabajo'
        )
        self.gasto2 = Gasto.objects.create(
            categoria=self.cat2,
            monto=120.75,
            fecha='2025-06-02',
            descripcion='Cena'
        )

    def test_redirect_anonymous_user(self):
        """Anonymous users should be redirected to login page"""
        response = self.client.get(reverse('gasto_list'))
        self.assertRedirects(response, f"{reverse('login')}?next={reverse('gasto_list')}")

    def test_logged_in_user_can_access(self):
        """Logged-in users should see the list view successfully"""
        self.client.login(username='fede2', password='hola1234')
        response = self.client.get(reverse('gasto_list'))
        self.assertEqual(response.status_code, 200)
        self.assertTemplateUsed(response, 'gasto_list.html')

    def test_gastos_rendered_in_context(self):
        """The response should contain the created gastos"""
        self.client.force_login(self.user)
        response = self.client.get(reverse('gasto_list'))
        # Check that both gastos appear in the page content
        self.assertContains(response, 'Taxi al trabajo')
        self.assertContains(response, 'Cena')
        # Ensure both categories appear in sidebar
        self.assertContains(response, 'Transporte')
        self.assertContains(response, 'Alimentación')


class GastoCreateViewTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='fede2', password='hola1234')
        self.cat = Categoria.objects.create(nombre='TestCat')
        self.url = reverse('gasto_create')

    def test_redirect_anonymous_user(self):
        """Anonymous users must be redirected to login."""
        response = self.client.get(self.url)
        self.assertRedirects(response, f"{reverse('login')}?next={self.url}")

    def test_get_logged_in_user_shows_form(self):
        """GET request by logged-in user should return form page."""
        self.client.login(username='fede2', password='hola1234')
        res = self.client.get(self.url)
        self.assertEqual(res.status_code, 200)
        self.assertTemplateUsed(res, 'gasto_form.html')
        self.assertContains(res, '<form')  # presence of form tag

    def test_post_valid_data_creates_gasto(self):
        """POST with valid data should create Gasto and redirect."""
        self.client.login(username='fede2', password='hola1234')
        data = {
            'categoria': self.cat.id,
            'monto': '99.99',
            'fecha': '2025-07-01',
            'descripcion': 'Test gasto',
        }
        res = self.client.post(self.url, data)
        self.assertEqual(res.status_code, 302)
        self.assertTrue(Gasto.objects.filter(descripcion='Test gasto').exists())
        gasto = Gasto.objects.get(descripcion='Test gasto')
        self.assertEqual(str(gasto.monto), data['monto'])
        self.assertEqual(gasto.categoria, self.cat)

    def test_post_invalid_data_shows_errors(self):
        """POST missing monto shouldn't create a Gasto."""
        self.client.login(username='fede2', password='hola1234')
        invalid_data = {
            'categoria': self.cat.id,
            'fecha': '2025-07-01'
        }
        res = self.client.post(self.url, invalid_data)
        self.assertEqual(res.status_code, 200)

        form = res.context['form']
        self.assertFalse(form.is_valid())
        self.assertIn('monto', form.errors)
        self.assertEqual(form.errors['monto'], ['This field is required.'])
        self.assertFalse(Gasto.objects.exists())
