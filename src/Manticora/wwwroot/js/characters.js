function searchCharacters(pageNumber) {
    let searchName = document.getElementById('searchInput').value;
    let currentPage = document.getElementById('currentPage').value;

    if (pageNumber)
        currentPage = pageNumber;

    let url = `/Characters/GetCharactersPartial?page=${currentPage}&name=${searchName}`;

    $.get(url, function (data) {
        $("#charactersDiv").html(data);
    });
}

function getCharacterDetails(id) {
    let url = `/Characters/GetCharacterDetails?id=${id}`;

    $.get(url, function (data) {
        $("#character-content").html(data);

        $("#character-modal").modal("show");
    });
}