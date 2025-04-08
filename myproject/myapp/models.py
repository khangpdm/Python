# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class NganHangCauHoi(models.Model):
    noi_dung = models.TextField()
    dap_an_A = models.TextField(db_column='dap_an_A')
    dap_an_B = models.TextField(db_column='dap_an_B')
    dap_an_C = models.TextField(db_column='dap_an_C')
    dap_an_D = models.TextField(db_column='dap_an_D')
    dap_an_dung = models.CharField(max_length=1, choices=[('A', 'A'), ('B', 'B'), ('C', 'C'), ('D', 'D')], null=True, blank=True)

    class Meta:
        managed = False
        db_table = 'ngan_hang_cau_hoi'
        
class DeThi(models.Model):
    ten_de = models.CharField(max_length=255)
    ma_de = models.CharField(max_length=20)
    ngay_tao = models.DateTimeField(auto_now_add=True)
    id_giao_vien = models.IntegerField()  # hoặc ForeignKey nếu có bảng GiaoVien

    class Meta:
        db_table = 'de_thi'  # chỉ định đúng tên bảng có sẵn trong DB
        managed = False  # vì bảng đã tồn tại, không cho Django tạo/migrate


class DeThiChiTiet(models.Model):
    de_thi = models.ForeignKey('DeThi', on_delete=models.CASCADE, db_column='de_thi_id')
    cau_hoi = models.ForeignKey('NganHangCauHoi', on_delete=models.CASCADE, db_column='cau_hoi_id')
    thu_tu = models.IntegerField()

    class Meta:
        db_table = 'de_thi_chi_tiet'
        managed = False  # Vì bảng đã có sẵn trong database