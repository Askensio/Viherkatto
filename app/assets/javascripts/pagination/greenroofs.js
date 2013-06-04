/**
 * Created with JetBrains RubyMine.
 * User: vito
 * Date: 3.6.2013
 * Time: 13:13
 * To change this template use File | Settings | File Templates.
 */
$(document).ready(function () {

    (function () {
        getGreenroofs();
    })();

    function paginate(entry_count, page, per_page) {
        var total = Math.ceil(entry_count / per_page);
        $('.pagination').empty()
        $('.pagination').bootpag({
            total: total,
            page: page,
            maxVisible: 10
        }).on('page', function (event, num) {
                getGreenroofs(num, per_page)
            });
    }

    function getGreenroofs(page, per_page, onDelete) {
        var currentuser = getCurrentUser();
        var reloadPaginateNeeded = false;
        if (page === undefined && per_page === undefined) reloadPaginateNeeded = true;
        if (page === undefined) page = 1;
        if (per_page === undefined)  per_page = 20;
        if (onDelete === undefined)  onDelete = false;

        if (onDelete) reloadPaginateNeeded = onDelete;

        $.getJSON("/greenroofs.json?page=" + page + "&per_page=" + per_page, function (data) {

            var entry_count = data["count"];
            var greenroofs = data["greenroofs"];
            var users = data["user"];

            if (greenroofs.length === 0) {
                reloadPaginateNeeded = true
                page -= 1
            }
            if (reloadPaginateNeeded) {
                paginate(entry_count, page, per_page)
                console.log("reloading pagination")
                reloadPaginateNeeded = false;
            }
            // Clears the greenroof list.
            $('.greenroof-list').empty();
            // And lists the queried greenroofs.
            $.each(greenroofs, function (i, item) {
                addGreenroofElement(item, findUserById(item.user_id, users), currentuser);
            });
        });
    }

    function getCurrentUser() {
        var mydata = [];
        $.ajax({
            url: '/getcurrentuser',
            async: false,
            dataType: 'json',
            success: function (json) {
                mydata = json;
            }
        });
        return mydata;
    }

    function findUserById(grUser, users) {
        var jsonArray = JSON.parse(users);
        var palautettava = "Username not found";

        $.each(jsonArray, function (i, item) {
            if (item["id"] == grUser) {
                palautettava = item;
                return false;
            }
        });
        return palautettava;
    }

    function addGreenroofElement(entry, user, currentuser) {

        var listElement = $('<li></li>');
        var greenroofLink = $('<a href=\"/greenroofs/' + entry.id + '\">' + "Käyttäjän " + user["name"] + " viherkatto" + '</a>');

        listElement.append(greenroofLink);

        if (currentuser["name"] && currentuser["id"] == user["id"] || currentuser["admin"]) {
            listElement.append(' | ');
            var deleteElement = $('<a href=\"#\" id=\"/greenroofs/' + entry.id + '\">' + 'poista' + '</a>')
            listElement.append(deleteElement).append(' | ');
            var editElement = $('<a href=\"/greenroofs/' + entry.id + '/edit\">' + 'muokkaa' + '</a>');
            listElement.append(editElement);
        }

        $('.greenroof-list').append(listElement);
    }
});

