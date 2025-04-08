# myapp/forms.py
from django import forms
from .models import NganHangCauHoi, DeThi

class CauHoiForm(forms.ModelForm):
    class Meta:
        model = NganHangCauHoi
        fields = ['noi_dung', 'dap_an_A', 'dap_an_B', 'dap_an_C', 'dap_an_D', 'dap_an_dung']

class DeThiForm(forms.ModelForm):
    class Meta:
        model = DeThi
        fields = ['ten_de']
