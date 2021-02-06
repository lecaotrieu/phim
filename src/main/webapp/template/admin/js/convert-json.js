function convertToJson(formData) {
    var data = {};
    $.each(formData, function (i, v) {
        if (v.value != "") {
            var x = "[name='" + v.name + "']"
            if ($(x).attr("multiple") == "multiple" || $(x).attr("type") == "checkbox") {
                v.value = [v.value];
            }
            data = addData(data, v.name, v.value);
        }
    });
    return data;
}

function addData(data, name, value) {
    if (name.indexOf(".") != -1) {
        var x1 = name.substr(0, name.indexOf("."));
        var x2 = name.substr(name.indexOf(".") + 1);
        if (data[x1] == undefined) {
            data[x1] = {};
        }
        if (x2.indexOf(".") != -1) {
            data[x1] = addData(data[x1], x2, value);
        } else {
            if (Array.isArray(value)) {
                if (data[x1].length == undefined) {
                    data[x1] = [];
                }
                var i = data[x1].length;
                var c1 = {};
                c1[x2] = value[0];
                data[x1][i] = c1;
            } else {
                data[x1][x2] = value;
            }
        }
    } else {
        if (Array.isArray(value)) {
            if (data[x1].length == undefined) {
                data[x1] = [];
            }
            var i = data[x1].length;
            var c1 = {};
            c1[x2] = value[0];
            data[x1][i] = c1;
        } else {
            data[name] = value;
        }
    }
    return data;
}

/*if (data[x1][x2] == undefined) {
                data[x1][x2] = value;
            } else {
                var c1 = {};
                c1[x2] = data[x1][x2];
                data[x1] = [];
                data[x1][0] = c1;
                var c2 = {};
                c2[x2] = value;
                data[x1][1] = c2;
            }
        } else {
            var x = {};
            x[x2] = value;
            data[x1][data[x1].length] = x;
        }*/