from django.shortcuts import render
from django.views.generic import ListView, CreateView, UpdateView
from django.urls import reverse_lazy
from .models import Gasto
from .forms import GastoForm

class GastoListView(ListView):
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
