const filtra = (type) => {
    var campo = document.getElementById(type);
    var tipo = type.toLowerCase();
    if (valida(tipo, campo) === 1) {
        return;
    }
    var filtrado = "";
    var filtrar = String(campo.value);

    for (i = 0; i <= campo.value.length; i++) {
        if (
            filtrar.substr(i, 1).charCodeAt(0) >= 48 &&
            filtrar.substr(i, 1).charCodeAt(0) <= 57
        ) {
            filtrado += filtrar.substr(i, 1);
        }
    }
    if (tipo === 'cep') {
        formataCEP(campo, filtrado);
    }
    if (tipo === 'cpf') {
        formataCPF(campo, filtrado);
    }
    if (tipo === 'cnpj') {
        formataCNPJ(campo, filtrado);
    }
    if (tipo === 'telefone') {
        formataTelefone(campo, filtrado);
    }
    if (tipo === 'inscEstadual') {
        formataInscEst(campo, filtrado);
    }
};

const valida = (tipo, campo) => {
    var pattern;

    if (tipo === 'cep') {
        pattern = /^\d{2}.\d{3}-\d{3}$/;
    }
    if (tipo === 'cpf') {
        pattern = /^\d{3}.\d{3}.\d{3}-\d{2}$/;
    }
    if (tipo === 'cnpj') {
        pattern = /^\d{2}.\d{3}.\d{3}\/\d{4}-\d{2}$/;
    }
    if (tipo === 'telefone') {
        pattern = /^\(\d{2}\)\d{4,5}-\d{4}$/;
    }
    if (tipo === 'inscEstadual') {
        pattern = /^\d{3}.\d{3}.\d{3}.\d{3}$/;
    }

    if (!pattern.test(campo.value)) {
        return 0;
    } else {
        return 1;
    }
}

/*
* -------- CPF
*/

const formataCPF = (cpf, filtrado) => {
    var formatado = "";
    var temp = filtrado;
    if (temp.length <= 3) {
        if (temp.legth !== 0 && temp !== "") {
            formatado = temp;
        }
    }
    if (temp.length > 3 && temp.length <= 6) {
        formatado = temp.substr(0, 3);
        formatado += ".";
        formatado += temp.substr(3, 3);
    }
    if (temp.length > 6) {
        formatado = temp.substr(0, 3);
        formatado += ".";
        formatado += temp.substr(3, 3);
        formatado += ".";
        formatado += temp.substr(6, 3);
    }
    if (temp.length > 9) {
        formatado = temp.substr(0, 3);
        formatado += ".";
        formatado += temp.substr(3, 3);
        formatado += ".";
        formatado += temp.substr(6, 3);
        formatado += "-";
        formatado += temp.substr(9, 2);
    }
    cpf.value = formatado;
}

/*
* -------- Inscrição Estadual
*/

const formataInscEst = (inscEstadual, filtrado) => {
    var formatado = "";
    var temp = filtrado;
    if (temp.length <= 3) {
        if (temp.legth !== 0 && temp !== "") {
            formatado = temp;
        }
    }
    if (temp.length > 3 && temp.length <= 6) {
        formatado = temp.substr(0, 3);
        formatado += ".";
        formatado += temp.substr(3, 3);
    }
    if (temp.length > 6) {
        formatado = temp.substr(0, 3);
        formatado += ".";
        formatado += temp.substr(3, 3);
        formatado += ".";
        formatado += temp.substr(6, 3);
    }
    if (temp.length > 9) {
        formatado = temp.substr(0, 3);
        formatado += ".";
        formatado += temp.substr(3, 3);
        formatado += ".";
        formatado += temp.substr(6, 3);
        formatado += ".";
        formatado += temp.substr(9, 3);
    }
    console.log(formatado);
    console.log(inscEstadual);
    inscEstadual.value = formatado;
}

/*
* -------- CEP
*/

const formataCEP = (cep, filtrado) => {
    var formatado = "";
    var temp = String(filtrado);
    if (temp.length <= 2) {
        if (temp.legth !== 0 && temp !== "") {
            formatado = temp;
        }
    }
    if (temp.length > 2 && temp.length <= 5) {
        formatado = temp.substr(0, 2);
        formatado += ".";
        formatado += temp.substr(2, 3);
    }
    if (temp.length > 5) {
        formatado = temp.substr(0, 2);
        formatado += ".";
        formatado += temp.substr(2, 3);
        formatado += "-";
        formatado += temp.substr(5, 3);
    }
    if (temp.length >= 10) {
        valida('cep', cep);
    }
    if (temp.length < 10) {
        cep.style.border = "solid 1px gray";
    }
    cep.value = formatado;
}

/*
* -------- CNPJ
*/

const formataCNPJ = (cnpj, filtrado) => {
    var formatado = "";
    var temp = filtrado;
    if (temp.length <= 2) {
        if (temp.legth !== 0 && temp !== "") {
            formatado = temp;
        }
    }
    if (temp.length > 2 && temp.length <= 5) {
        formatado = temp.substr(0, 2);
        formatado += ".";
        formatado += temp.substr(2, 3);
    }
    if (temp.length > 5 && temp.length <= 8) {
        formatado = temp.substr(0, 2);
        formatado += ".";
        formatado += temp.substr(2, 3);
        formatado += ".";
        formatado += temp.substr(5, 3);
    }
    if (temp.length > 8 && temp.length <= 12) {
        formatado = temp.substr(0, 2);
        formatado += ".";
        formatado += temp.substr(2, 3);
        formatado += ".";
        formatado += temp.substr(5, 3);
        formatado += "/";
        formatado += temp.substr(8, 4);
    }
    if (temp.length > 12) {
        formatado = temp.substr(0, 2);
        formatado += ".";
        formatado += temp.substr(2, 3);
        formatado += ".";
        formatado += temp.substr(5, 3);
        formatado += "/";
        formatado += temp.substr(8, 4);
        formatado += "-";
        formatado += temp.substr(12, 2);
    }
    cnpj.value = formatado;
}

/*
* -------- TELEFONE
*/

const formataTelefone = (telefone, filtrado) => {
    var formatado = "";
    if (filtrado.length <= 2) {
        if (filtrado.legth !== 0 && filtrado !== "") {
            formatado = "(" + filtrado + ")";
        }
    }
    if (filtrado.length > 2 && filtrado.length <= 6) {
        formatado = "(";
        formatado += filtrado.substr(0, 2);
        formatado += ")";
        formatado += filtrado.substr(2, 4);
    }
    if (filtrado.length > 6) {
        formatado = "(";
        formatado += filtrado.substr(0, 2);
        formatado += ")";
        formatado += filtrado.substr(2, 4);
        formatado += "-";
        formatado += filtrado.substr(6, 4);
    }
    if (filtrado.length > 9) {
        formatado = "(";
        formatado += filtrado.substr(0, 2);
        formatado += ")";
        formatado += filtrado.substr(2, 5);
        formatado += "-";
        formatado += filtrado.substr(7, 4);
    }
    if (filtrado.length > 10 && filtrado.substr(0, 2) == "08") {
        formatado = filtrado.substr(0, 4);
        formatado += "-";
        formatado += filtrado.substr(4, 3);
        formatado += "-";
        formatado += filtrado.substr(7, 4);
    }
    telefone.value = formatado;
}


/*
* ------- DATA
*/

const setDate = () => {
    var listaData = document.getElementsByClassName("data");

    for (var i = 0; i < listaData.length; i++) {
        var date = new Date(listaData[i].innerHTML);
        listaData[i].innerHTML = formataData(date);
    }
};

const formataData = (date) => {
    var dia = date.getDay();
    var mes;
    var ano = date.getFullYear();
    switch (date.getMonth()) {
        case 1:
            mes = 'JAN';
            break;
        case 2:
            mes = 'FEV';
            break;
        case 3:
            mes = 'MAR';
            break;
        case 4:
            mes = 'ABR';
            break;
        case 5:
            mes = 'MAIO';
            break;
        case 6:
            mes = 'JUN';
            break;
        case 7:
            mes = 'JUL';
            break;
        case 8:
            mes = 'AGO';
            break;
        case 9:
            mes = 'SET';
            break;
        case 10:
            mes = 'OUT';
            break;
        case 11:
            mes = 'NOV';
            break;
        case 12:
            mes = 'DEZ';
            break;
        default:
            mes = 'nulo';
            break;
    }
    return dia + " " + mes + " " + ano;
};
