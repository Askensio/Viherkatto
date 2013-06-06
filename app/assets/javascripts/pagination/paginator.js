function Pagination(url, page, per_page, param) {

    if (param === undefined)  param = "";

    this.object = getObject()
    this.parameters = param
    this.url = url
    this.entry_count = 0;
    this.page = page
    this.per_page = per_page;
    this.total = 0

    function getObject() {
        return $('body').find('ul[data-id]').attr('data-id')
    }
}

Pagination.prototype.deleteRequest = (function (paginator) {

    return function (e) {

        var url = e.target.getAttribute('id')

        $.ajax({
            url: url,
            type: 'DELETE',
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            },
            success: function (response) {
                callbackHandler(response)
            }
        });

        function callbackHandler(result) {
            //console.log(result)
            var alert = $('<div></div>').attr('class', 'alert alert-' + result.response)
            if (result.response === 'success') {
                alert.append("Poisto onnistui.")
            }
            else {
                alert.append("Poisto epäonnistui.")
            }
            $('.alert').remove()
            //$('.pagination').before(alert)
            //console.log(alert)
            //paginator.paginate()
            paginator.getObjects()
        }
    }
})


Pagination.prototype.paginate = function () {
    var paginateBarListener = (function (paginator) {
        return function (event, page) {
            //console.log("jee")
            paginator.page = page
            paginator.getObjects()
        }
    })(this)

    $('.pagination').bootpag({
        total: this.total,   // total pages
        page: this.page,     // default page
        maxVisible: 10  // visible pagination
    }).on('page', paginateBarListener);
    $('.pagination').click(function () {
        $('.alert').remove()
    })
}

Pagination.prototype.getObjects = function (render) {

    if (render === undefined)  render = false;

    var paginator = this

    $.getJSON("/" + this.url + ".json?" + this.parameters + "page=" + this.page + "&per_page=" + this.per_page, function (data) {
        callbackHandler(data)
    });

    function callbackHandler(data) {
        console.log(data)
        paginator.entry_count = data["count"];

        console.log('total ' + paginator.total)
        console.log('page ' + paginator.page)
        console.log('entry_count ' + paginator.entry_count)
        console.log('per_page ' + paginator.per_page)
        console.log('laskutoimitus ' + Math.ceil(paginator.entry_count / paginator.per_page))

        var currentPages = Math.ceil(paginator.entry_count / paginator.per_page)

        if( currentPages < paginator.total ) {
            console.log("sivun pitäisi kadota!!!")
            paginator.total = currentPages
            paginator.paginate()
        }

        paginator.total = currentPages

        var objects = data[ paginator.object + "s" ];
        //console.log(objects)
        if (objects.length === 0) {

            //console.log("no lenght :(")
            //    paginator.page -= 1
            //$('.pagination').empty()
            paginator.paginate()
            //paginator.getObjects()
            //    paginator.getObjects()
            //return
        }
        if (render) {
            console.log("rendaah!")
            $('.pagination').empty()
            paginator.paginate()
            //console.log("reloadin pagination")
            render = false;
        }

        // Clears the list.
        $('.' + paginator.object + '-list').empty();
        // And lists the queried objects.
        $.each(objects, function (i, item) {
            paginator.addElement(item, data["admin"]);
        });
    }
}

Pagination.prototype.addElement = addElement

