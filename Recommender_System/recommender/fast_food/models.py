from django.db import models
from django.contrib.auth import get_user_model

User = get_user_model()

# Create your models here.
class Restaurant(models.Model):
    name = models.CharField('name',max_length=50)
    address = models.CharField('Restaurant address', max_length=100, default='NY')
    website = models.CharField('Restaurant website', max_length=100, default='www.com')
    #categories = ArrayField(models.CharField(max_length=100))

class Rating(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    restaurant = models.ForeignKey(Restaurant, on_delete=models.CASCADE)
    rate = models.SmallIntegerField(range(0,5))


"""class Category (models.Model):
    name = models.CharField('name',max_length=100)

class RestaurantCategories(models.Model):
    restaurant = models.ForeignKey(Restaurant, on_delete=models.CASCADE)
    category = models.ForeignKey(Category, on_delete=models.CASCADE)"""
