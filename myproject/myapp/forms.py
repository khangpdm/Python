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



from django import forms
from django.core.exceptions import ValidationError
from .models import HocSinh, GiaoVien

class StudentRegistrationForm(forms.Form):
    ten_dang_nhap = forms.CharField(max_length=50, label='Tên đăng nhập', required=True)
    mat_khau = forms.CharField(widget=forms.PasswordInput, label='Mật khẩu', required=True)
    xac_nhan_mat_khau = forms.CharField(widget=forms.PasswordInput, label='Xác nhận mật khẩu', required=True)

    def clean_ten_dang_nhap(self):
        ten_dang_nhap = self.cleaned_data['ten_dang_nhap']
        if HocSinh.objects.filter(ten_dang_nhap=ten_dang_nhap).exists():
            raise ValidationError('Tên đăng nhập đã tồn tại.')
        return ten_dang_nhap

    def clean(self):
        cleaned_data = super().clean()
        mat_khau = cleaned_data.get('mat_khau')
        xac_nhan_mat_khau = cleaned_data.get('xac_nhan_mat_khau')
        if mat_khau and xac_nhan_mat_khau and mat_khau != xac_nhan_mat_khau:
            raise ValidationError('Mật khẩu và xác nhận mật khẩu không khớp.')
        return cleaned_data

class UserRegistrationForm(forms.Form):
    ten_dang_nhap = forms.CharField(max_length=50, label='Tên đăng nhập', required=True)
    mat_khau = forms.CharField(widget=forms.PasswordInput, label='Mật khẩu', required=True)
    xac_nhan_mat_khau = forms.CharField(widget=forms.PasswordInput, label='Xác nhận mật khẩu', required=True)

    def clean_ten_dang_nhap(self):
        ten_dang_nhap = self.cleaned_data['ten_dang_nhap']
        if GiaoVien.objects.filter(ten_dang_nhap=ten_dang_nhap).exists():
            raise ValidationError('Tên đăng nhập đã tồn tại.')
        return ten_dang_nhap

    def clean(self):
        cleaned_data = super().clean()
        mat_khau = cleaned_data.get('mat_khau')
        xac_nhan_mat_khau = cleaned_data.get('xac_nhan_mat_khau')
        if mat_khau and xac_nhan_mat_khau and mat_khau != xac_nhan_mat_khau:
            raise ValidationError('Mật khẩu và xác nhận mật khẩu không khớp.')
        return cleaned_data