$(document).ready(function () {

    FOTO.Slider.baseURL = '/assets';

    FOTO.Slider.bucket = {
        'default': {
            0: {'thumb': 'greenroof1.jpg', 'main': 'greenroof1.jpg'},
            1: {'thumb': 'greenroof2.jpg', 'main': 'greenroof2.jpg'},
            2: {'thumb': 'greenroof3.JPG', 'main': 'greenroof3.JPG'},
            3: {'thumb': '2ndgreenroof.jpg', 'main': '2ndgreenroof.jpg'},
            4: {'thumb': 'kerola2.jpg', 'main': 'kerola2.jpg'},
            5: {'thumb': 'kisse.jpg', 'main': 'kisse.jpg'},
            6: {'thumb': 'gerollings.jpg', 'main': 'gerollings.jpg'}


        }
    };

    FOTO.Slider.reload('default');
    FOTO.Slider.enableSlideshow('default');
    FOTO.Slider.play('default')
});