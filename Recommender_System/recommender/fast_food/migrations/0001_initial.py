# Generated by Django 2.2.6 on 2019-11-03 03:33

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Category',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100, verbose_name='name')),
            ],
        ),
        migrations.CreateModel(
            name='Restaurant',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=50, verbose_name='name')),
                ('address', models.CharField(default='NY', max_length=100, verbose_name='Restaurant address')),
            ],
        ),
        migrations.CreateModel(
            name='RestaurantCategories',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('category', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='fast_food.Category')),
                ('restaurant', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='fast_food.Restaurant')),
            ],
        ),
    ]
