const selectedCharacters = [];

function setSelectedCharactersDB() {
    let selectedCharactersDB = document.getElementById('selectedCharactersDB').value;

    if (selectedCharactersDB) {
        selectedCharacters.length = 0;
        if (selectedCharactersDB.indexOf(',') >= 0) {
            let selectedArray = selectedCharactersDB.split(',');
            for (let i = 0; i < selectedArray.length; i++)
                selectedCharacters.push(selectedArray[i]);
        }
        else
            selectedCharacters.push(selectedCharactersDB);
    }
}

function searchCharacters(pageNumber) {
    let searchName = document.getElementById('searchInput').value;
    let currentPage = document.getElementById('currentPage').value;
    setSelectedCharactersDB();

    if (pageNumber)
        currentPage = pageNumber;

    let url = `/Characters/GetCharactersPartial?page=${currentPage}&name=${searchName}`;

    if (selectedCharacters != null && selectedCharacters.length > 0) {
        let selectedIds = selectedCharacters.join(',');
        url = url + `&selected=${selectedIds}`;
    }

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

function selectCharacter(chk, id) {
    setSelectedCharactersDB();

    if (chk.checked && selectedCharacters != null && selectedCharacters.length >= 2) {
        chk.checked = false;

        Swal.fire({
            icon: "warning",
            title: "Información",
            confirmButtonText: "Aceptar",
            backdrop: false,
            theme: "light",
            text: "Ya existen dos personajes seleccionados!"
        });
        return;
    }

    if (chk.checked)
        selectedCharacters.push(id);
    else
        selectedCharacters.splice(selectedCharacters.indexOf(id), 1);

    document.getElementById("btnPlay").hidden = (selectedCharacters.length < 2);      
    document.getElementById('selectedCharactersDB').value = selectedCharacters.join(',');

    let url = `/Characters/SelectCharacter?id=${id}&selected=${chk.checked}`;
    $.post(url, function (data) {
        if (data.isSuccess == true) {
            let equipCharacterId = chk.id.replace('select', 'equipCharacter');
            let equipCharacterButton = document.getElementById(equipCharacterId);
            equipCharacterButton.hidden = !chk.checked;
        }
        else {
            chk.checked = false;
            console.log(data.message);
            Swal.fire({
                icon: "error",
                title: "Información",
                confirmButtonText: "Aceptar",
                backdrop: false,
                theme: "light",
                text: "Ocurrió un error al guardar el registro en la base de datos!"
            });
        }
    });
}

function equipCharacter(id) {
    let url = `/Characters/EquipCharacter?id=${id}`;

    $.get(url, function (data) {
        $("#character-content").html(data);

        $("#character-modal").modal("show");
    });
}

function buy(characterId, weaponId) {
    let url = `/Characters/Buy?characterId=${characterId}&weaponId=${weaponId}`;

    $.post(url, function (data) {
        $("#inventoryDiv").html(data);
    });
}