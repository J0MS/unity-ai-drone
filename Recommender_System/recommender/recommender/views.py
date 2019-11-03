from django.shortcuts import render


def index(request):
    return render(request, 'global/index.html', {'title': 'Home', 'index': 'active'})
