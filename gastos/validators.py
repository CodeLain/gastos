from django.contrib.auth.password_validation import MinimumLengthValidator
from django.core.exceptions import ValidationError
from django.utils.translation import ngettext

class CustomMinimumLengthValidator(MinimumLengthValidator):
    def __init__(self, min_length=8):
        super().__init__(min_length=min_length)

    def validate(self, password, user=None):
        if len(password) < self.min_length:
            # custom Spanish error message
            raise ValidationError(
                "La contraseña debe tener al menos %(min_length)d caracteres.",
                code='password_too_short',
                params={'min_length': self.min_length}
            )

    def get_help_text(self):
        return f"La contraseña debe tener al menos {self.min_length} caracteres."