function addressChange() {
    $('#country').on("change", function () {
        var countryValue = $('#country').val();
        var url = '<c:url value="/ajax/city/list?countryId="/>' + countryValue + "";
        $('#city').load(url);
        $('#district').load('<c:url value="/ajax/district/list?cityId="/>');
        $('#commune').load('<c:url value="/ajax/commune/list?districtId="/>');
    });

    $('#city').on("change", function () {
        var cityValue = $('#city').val();
        var url = '<c:url value="/ajax/district/list?cityId="/>' + cityValue + "";
        $('#district').load(url);
        $('#commune').load('<c:url value="/ajax/commune/list?districtId="/>');
    });

    $('#district').on("change", function () {
        var districtValue = $('#district').val();
        var url = '<c:url value="/ajax/commune/list?districtId="/>' + districtValue + "";
        $('#commune').load(url);
    });
}
