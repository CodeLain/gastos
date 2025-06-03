from django.urls import path
from .views import GastoListView, GastoCreateView, GastoUpdateView
from .views import registro


urlpatterns = [
    path('', GastoListView.as_view(), name='gasto_list'),
    path('nuevo/', GastoCreateView.as_view(), name='gasto_create'),
    path('editar/<int:pk>/', GastoUpdateView.as_view(), name='gasto_edit'),
    path('registro/', registro, name='registro'),
]