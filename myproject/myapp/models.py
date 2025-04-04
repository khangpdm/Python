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
    dap_an_A = models.TextField(db_column='dap_an_A')  # Field name made lowercase.
    dap_an_B = models.TextField(db_column='dap_an_B')  # Field name made lowercase.
    dap_an_C = models.TextField(db_column='dap_an_C')  # Field name made lowercase.
    dap_an_D = models.TextField(db_column='dap_an_D')  # Field name made lowercase.
    dap_an_dung = models.JSONField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ngan_hang_cau_hoi'
