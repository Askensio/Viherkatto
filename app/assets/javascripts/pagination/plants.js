$(document).ready(function () {

    (function () {
        getPlants();
    })();


    function paginate(entry_count, page, per_page) {
        var total = Math.ceil(entry_count / per_page);
        $('.pagination').empty()
        $('.pagination').bootpag({
            total: total,
            page: page,
            maxVisible: 10
        }).on('page', function (event, num) {
                getPlants(num, per_page)
            });
    }

    function getPlants(page, per_page, onDelete) {
        var reloadPaginateNeeded = false;
        if (page === undefined && per_page === undefined) reloadPaginateNeeded = true;
        if (page === undefined) page = 1;
        if (per_page === undefined)  per_page = 20;
        if (onDelete === undefined)  onDelete = false;

        if(onDelete) reloadPaginateNeeded = onDelete;

        $.getJSON("/plants.json?page=" + page + "&per_page=" + per_page, function (data) {

            var entry_count = data["count"];
            var plants = data["plants"];
            if(plants.length === 0) {
                reloadPaginateNeeded = true
                page -= 1
            }
            if (reloadPaginateNeeded) {
                paginate(entry_count, page, per_page)
                console.log("reloadin pagination")
                reloadPaginateNeeded = false;
            }
            // Clears the plant list.
            $('.plant-list').empty();
            // And lists the queried plants.
            $.each(plants, function (i, item) {
                addPlantElement(item);
            });
        });
    }

    function addPlantElement(entry) {

        var listElement = $('<li></li>');
        var plantLink = $('<a href=\"/plants/' + entry.id + '\">' + entry.name + '</a>');
        listElement.append(plantLink);
        listElement.append(' | ');
        var deleteElement = $('<a href=\"#\" id=\"/plants/' + entry.id + '\">' + 'poista' + '</a>').click(
            function (e) {
                var url = e.target.getAttribute('id')
                $.ajax({
                    url: url,
                    type: 'DELETE',
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
                    },
                    success: function (result) {
                        var pagenr = 0;
                        var pageItems = $('.bootpag').children();
                        $.each(pageItems, function (i, item) {
                            var cl =  $(item).attr("class");

                            if(cl === "disabled") {
                                pagenr = $(item).attr("data-lp");
                            }
                        });
                        getPlants(pagenr, 5, true)
                    }
                });

            });
        listElement.append(deleteElement).append(' | ');
        var editElement = $('<a href=\"/plants/' + entry.id + '/edit\">' + 'muokkaa' + '</a>');
        listElement.append(editElement);
        $('.plant-list').append(listElement);
    }

    function addPlantElementForSearch(entry) {

        var listElement = $('<li></li>');
        var plantLink = $('<a href=\"/plants/' + entry.id + '\">' + entry.name + '  </a>');
        listElement.append(plantLink);
        listElement.append('<i class=\"icon-plus pull-right\"></i>');
        $('.plant-list').append(listElement);
    }


    var $cells = $("li");
    var plantdata = [];

    $("#search").keyup(function() {
        $('.plant-list').empty();
      //  var val = $.trim(this.value).toUpperCase();
      //  if (val === "")
      //      $cells.parent().show();
      //  else {
      //      $cells.parent().hide();
       //     $cells.filter(function() {
      //          return -1 != $(this).text().toUpperCase().indexOf(val); }).parent().show();
        //}
       if (plantdata.length === 0) {
           $.getJSON("/plants.json", function (data) {
               plantdata = data["plants"];
               console.log(plantdata);
           });
       }

       $.each(plantdata, function (i, item) {
            var searchword = $("#search").val();
            if ( item.name.toLocaleLowerCase().indexOf(searchword) >= 0 ) {
                addPlantElementForSearch(item);
            }
            console.log(searchword);
            console.log(item.name);
       });
    });

});

