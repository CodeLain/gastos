from django.db import models

# Create your models here.


class Categoria(models.Model):
    nombre = models.CharField(max_length=100)
    # usuario = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return self.nombre

class Gasto(models.Model):
    # usuario = models.ForeignKey(User, on_delete=models.CASCADE)
    categoria = models.ForeignKey(Categoria, on_delete=models.CASCADE)
    monto = models.DecimalField(max_digits=10, decimal_places=2)
    fecha = models.DateField()
    descripcion = models.TextField(blank=True, null=True)
    imagen = models.ImageField(upload_to='recibos/', blank=True, null=True)

    def __str__(self):
        return f"{self.monto} - {self.categoria.nombre}"