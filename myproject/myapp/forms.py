# myapp/forms.py
from django import forms
from .models import NganHangCauHoi

class CauHoiForm(forms.ModelForm):
    class Meta:
        model = NganHangCauHoi
        fields = ['noi_dung', 'dap_an_A', 'dap_an_B', 'dap_an_C', 'dap_an_D', 'dap_an_dung']