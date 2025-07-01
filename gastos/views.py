from django.contrib.auth.views import LogoutView
from django.shortcuts import render, redirect
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt
from django.views.generic import ListView, CreateView, UpdateView, DeleteView
from django.urls import reverse_lazy
from .models import Gasto, Categoria
from .forms import GastoForm
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.auth import login
from .forms import RegistroForm
@method_decorator(csrf_exempt, name='dispatch')
class GastoListView(LoginRequiredMixin, ListView):
    model = Gasto
    template_name = 'gasto_list.html'
    context_object_name = 'gastos'
    login_url = 'login'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['sidebar_categories'] = Categoria.objects.all()
        return context

@method_decorator(csrf_exempt, name='dispatch')
class GastoCreateView(CreateView):
    model = Gasto
    fields = ['categoria', 'monto', 'fecha', 'descripcion', 'imagen']  # or use form_class = GastoForm
    template_name = 'gasto_form.html'
    success_url = reverse_lazy('gasto_list')

    def form_invalid(self, form):
        print("Form errors:", form.errors)  # Helpful for debugging
        return super().form_invalid(form)
@method_decorator(csrf_exempt, name='dispatch')
class GastoUpdateView(UpdateView):
    model = Gasto
    form_class = GastoForm
    template_name = 'gasto_form.html'
    success_url = reverse_lazy('gasto_list')


def registro(request):
    if request.method == 'POST':
        form = RegistroForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)  # Log in the new user
            return redirect('gasto_list')
    else:
        form = RegistroForm()
    return render(request, 'registro.html', {'form': form})

@method_decorator(csrf_exempt, name='dispatch')
class CategoriaCreateView(LoginRequiredMixin, CreateView):
    model = Categoria
    fields = ['nombre']
    template_name = 'categoria_form.html'
    success_url = reverse_lazy('gasto_list')

@method_decorator(csrf_exempt, name='dispatch')
class CategoriaUpdateView(LoginRequiredMixin, UpdateView):
    model = Categoria
    fields = ['nombre']
    template_name = 'categoria_form.html'
    success_url = reverse_lazy('gasto_list')

@method_decorator(csrf_exempt, name='dispatch')
class LogoutWithoutCSRF(LogoutView):
    pass

@method_decorator(csrf_exempt, name='dispatch')
class GastoDeleteView(LoginRequiredMixin, DeleteView):
    model = Gasto
    success_url = reverse_lazy('gasto_list')