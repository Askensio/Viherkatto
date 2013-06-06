$(document).ready(function () {
    var paginator = new Pagination()

    paginator.getObjects()
});

function Pagination() {

    this.object = getObject()

    function getObject() {
        return $('body').find('ul[data-id]').attr('data-id')
    }

    this.deleteRequest = (function (paginator) {
        return function (e) {

            var url = e.target.getAttribute('id')

            var callback = function (result) {
                var pagenr = 0;
                var pageItems = $('.bootpag').children();
                $.each(pageItems, function (i, item) {
                    var cl = $(item).attr("class");

                    if (cl === "disabled") {
                        pagenr = $(item).attr("data-lp");
                    }
                });
                //console.log(paginator)
                paginator.getObjects(pagenr, 20, true)
            }

            $.ajax({
                url: url,
                type: 'DELETE',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
                },
                success: callback
            });
        }
    })(this)
}

Pagination.prototype.paginate = function (entry_count, page, per_page) {

    var paginateBarListener = (function(paginator) {
        return function (event, num) {
            paginator.getObjects(num, per_page)
        }
    })(this)

    var total = Math.ceil(entry_count / per_page);
    $('.pagination').empty()
    $('.pagination').bootpag({
        total: total,
        page: page,
        maxVisible: 10
    }).on('page', paginateBarListener);
}

Pagination.prototype.getObjects = function (page, per_page, onDelete) {
    var reloadPaginateNeeded = false;
    if (page === undefined && per_page === undefined) reloadPaginateNeeded = true;
    if (page === undefined) page = 1;
    if (per_page === undefined)  per_page = 20;
    if (onDelete === undefined)  onDelete = false;

    if (onDelete) reloadPaginateNeeded = onDelete;
    var callback = (function (paginator) {
        return function (data) {
//            console.log(data)
            var entry_count = data["count"];
            var objects = data[ paginator.object + "s" ];
            //console.log(objects)
            if (objects.length === 0) {
                reloadPaginateNeeded = true
                page -= 1
            }
            if (reloadPaginateNeeded) {
                paginator.paginate(entry_count, page, per_page)
                //console.log("reloadin pagination")
                reloadPaginateNeeded = false;
            }
            // Clears the list.
            $('.' + paginator.object + '-list').empty();
            // And lists the queried objects.
            $.each(objects, function (i, item) {
                paginator.addElement(item, data["admin"]);
            });
        };
    }(this))

    $.getJSON("/" + this.object + "s.json?page=" + page + "&per_page=" + per_page, callback);
}

Pagination.prototype.addElement = addElement

