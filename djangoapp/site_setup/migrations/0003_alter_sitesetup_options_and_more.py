# Generated by Django 5.1.5 on 2025-01-29 12:53

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('site_setup', '0002_sitesetup'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='sitesetup',
            options={'verbose_name': 'Setup', 'verbose_name_plural': 'Setup'},
        ),
        migrations.RenameField(
            model_name='sitesetup',
            old_name='tittle',
            new_name='title',
        ),
    ]
