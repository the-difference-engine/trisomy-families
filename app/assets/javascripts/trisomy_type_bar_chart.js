var trisomy_type = [];
var trisomy_type_hash = {};
var trisomy_type_hash_keys = [];
var trisomy_type_hash_values = [];
var birthdate = [];
var age = [];
 
$.getJSON('/api/v1/children', function(data) {
    data.forEach(function(child) {
        trisomy_type.push (child.trisomy_type);
        birthdate.push (child.birth_date);
    });
    trisomy_type.forEach(function(i) { 
        trisomy_type_hash[i] = (trisomy_type_hash[i]||0)+1;  
    });

    for (var property in trisomy_type_hash) {
        if ( ! data.hasOwnProperty(property)) {
            continue;
        }
        trisomy_type_hash_keys.push(property);
        trisomy_type_hash_values.push(trisomy_type_hash[property]);
    }





    // console.log(Object.prototype.toString.call(years));
    console.log(trisomy_type);
    console.log(birthdate);
    console.log("fuckoff");
    console.log(trisomy_type_hash);
    console.log(trisomy_type_hash_keys);
    console.log(trisomy_type_hash_values);


$(function () { 
Highcharts.chart('container', {
    chart: {
        type: 'bar'
    },
    title: {
        text: ''
    },
    xAxis: {
        categories: trisomy_type_hash_keys,
        title: {
            text: null
        }
    },
    yAxis: {
        min: 0,
        title: {
            text: 'Population (millions)',
            align: 'high'
        },
        labels: {
            overflow: 'justify'
        }
    },
    tooltip: {
        valueSuffix: ' millions'
    },
    plotOptions: {
        bar: {
            dataLabels: {
                enabled: true
            }
        }
    },
    legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'top',
        x: -40,
        y: 80,
        floating: true,
        borderWidth: 1,
        backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
        shadow: true
    },
    credits: {
        enabled: false
    },
    series: [{
        name: 'Number of Registered Children by Trisomy Type',
        data: trisomy_type_hash_values
    }]
});
}); 
}); 

