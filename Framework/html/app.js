var CurrentChar;
var depts;

$(() => {
    window.addEventListener('message', (e) => {
        if (e.data.action == 'open') {
            $('body').show();
            $('#characters').hide();
            $('#loader').fadeIn();
        } else if (e.data.action == 'setChars') {
            depts = e.data.levels;
            SetupDepartments(depts);
            SetupCharacters(e.data.chars, e.data.maxchars);
        } else if (e.data.action == 'setSpawns') {
            SetupSpawns(e.data.spawns);
        }
    });

    $('#disconnectBtn').click(function() {
        $.post('https://SAL-Framework/disconnect', JSON.stringify({}));
    });

    $('#deleteBtn').click(function() {
        $('#deleteModal').modal('hide');
        $('#characters').fadeOut(function() {
            $.post('https://SAL-Framework/deleteCharacter', JSON.stringify({
                char: CurrentChar
            }));
            $('#loader').fadeIn();
            $('#charcount').html('');
            $('#createCharBtn').attr('disabled', 'disabled');
        });
    });

    $('#refreshBtn').click(function() {
        $('#alert').hide()
        $('#characters').fadeOut(function() {
            $.post('https://SAL-Framework/refresh', JSON.stringify({}));
            $('#loader').fadeIn();
            $('#charcount').html('');
            $('#createCharBtn').attr('disabled', 'disabled');
        });
        $('#refreshBtn').attr('disabled', 'disabled');
    });


    $('#createCharForm').submit(function(e) {
        $('#alert').hide();
        $('#characters').fadeOut(function() {
            $('#loader').fadeIn();
            $('#charcount').html('');
            $('#createCharBtn').attr('disabled', 'disabled');
        });
        $.post('https://SAL-Framework/createCharacter', JSON.stringify({
            name: capitalize($('#fName').val()) + " " + capitalize($('#lName').val()),
            dob: $('#dob').val(),
            gender: $('#gender').val(),
            dept: $('#dept').val().toUpperCase()
        }));
        $('#createModal').modal('hide');
        $('#createCharForm').trigger("reset");
        e.preventDefault();
    });

    $('#editCharForm').submit(function(e) {
        $('#alert').hide()
        $('#characters').fadeOut(function() {
            $('#loader').fadeIn();
            $('#charcount').html('');
            $('#createCharBtn').attr('disabled', 'disabled');
        });
        $.post('https://SAL-Framework/editCharacter', JSON.stringify({
            id: CurrentChar.id,
            name: capitalize($('#efName').val()) + " " + capitalize($('#elName').val()),
            dob: $('#edob').val(),
            gender: $('#egender').val(),
            dept: $('#edept').val().toUpperCase()
        }));
        $('#editModal').modal('hide');
        $('#editCharForm').trigger("reset");
        e.preventDefault();
    });

    $('#spawns').on('click', '.spawn', function() {
       var data = $(this).data('spawn');
       $.post('https://SAL-Framework/spawn', JSON.stringify({
           spawn: data,
           char: CurrentChar
       }));
       $('#spawnModal').modal('hide');
       $('body').fadeOut();
    }); 
});

function SetupCharacters(chars, maxchars) {
    $('#characters').html('');
    $.each(chars, (index, char) => {
        $('#characters').append(`
            <div id="char-data-${index}" class="character m-2">
                <button type="button" class="btn btn-primary" onclick="getSpawns(${index})" data-toggle="modal" data-target="#spawnModal">Play as: ${char.char_name} (${char.dept})</button>
                <button type="button" class="btn btn-success" onclick="editChar(${index})" data-toggle="modal" data-target="#editModal"><i class="fas fa-edit"></i> Edit</button>
                <button type="button" class="btn btn-danger" onclick="selectChar(${index})" data-toggle="modal" data-target="#deleteModal"><i class="fas fa-trash-alt"></i> Delete</button>
            </div>
        `);
        $('#char-data-' + index).data(char)
    });

    $('#loader').fadeOut(function() {
        if (chars.length > 0) {
            $('#alert').fadeOut();
            $('#characters').fadeIn();
            $('#charcount').html(`(${chars.length}/${maxchars})`);
            if (chars.length < maxchars) {
                $('#createCharBtn').removeAttr('disabled');
            }
        } else {
            $('#alert').fadeIn();
            $('#createCharBtn').removeAttr('disabled');
        }
        $('#refreshBtn').removeAttr('disabled', 'disabled');
    });
}

function SetupDepartments(levels, editor) {
    if (editor) {
        $("#edept").html('');
        $.each(levels, (index, allowed) => {
            if (allowed) {
                $("#edept").append(`<option value="${index}">${index.toUpperCase()}</option>`);
            }
        });
        $('#edept').selectpicker('refresh');  
        $('#edept').selectpicker('render');
    } else {
        $("#dept").html('');
        $.each(levels, (index, allowed) => {
            if (allowed) {
                $("#dept").append(`<option value="${index}">${index.toUpperCase()}</option>`);
            }
        });  
        $('#dept').selectpicker('refresh');  
        $('#dept').selectpicker('render');
    }
}

function SetupSpawns(spawns) {
    $("#spawns").html('');

    $.each(spawns, (index, spawn) => {
        $("#spawns").append(`<button id="spawn-${index}" type="button" class="btn btn-primary spawn mb-1 mt-1">${spawn.label}</button>`);
        $("#spawn-"+index).data('spawn', spawn);
    });

    $('#spawnLoader').fadeOut(function() {
        $('#spawns').fadeIn();
    });
}

function getSpawns(index) {
    CurrentChar = $('#char-data-' + index).data();
    $('#spawns').hide();
    $('#spawnLoader').fadeIn();
    $.post('https://SAL-Framework/getSpawns', JSON.stringify({
        char: CurrentChar
    }))
}

function editChar(index) {
    CurrentChar = $('#char-data-' + index).data();
    var name = CurrentChar.char_name.split(" ");
    $('#editCharForm').trigger('reset');
    $('#efName').val(name[0]);
    $('#elName').val(name[1]);
    $('#edob').val(CurrentChar.dob);
    $('#egender').val(CurrentChar.gender);
    SetupDepartments(depts, true);
}

function selectChar(index) {
    CurrentChar = $('#char-data-' + index).data();
}

function capitalize(s) {
    if (typeof s !== 'string') return ''
    return s.charAt(0).toUpperCase() + s.slice(1)
}

