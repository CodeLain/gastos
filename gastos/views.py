from django.shortcuts import render, redirect
from django.views.generic import ListView, CreateView, UpdateView
from django.urls import reverse_lazy
from .models import Gasto
from .forms import GastoForm
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.auth import login
from .forms import RegistroForm

class GastoListView(ListView, LoginRequiredMixin):
    model = Gasto
    template_name = 'gasto_list.html'
    context_object_name = 'gastos'

class GastoCreateView(CreateView):
    model = Gasto
    fields = ['categoria', 'monto', 'fecha', 'descripcion', 'imagen']  # or use form_class = GastoForm
    template_name = 'gasto_form.html'
    success_url = reverse_lazy('gasto_list')

    def form_invalid(self, form):
        print("Form errors:", form.errors)  # Helpful for debugging
        return super().form_invalid(form)

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