var trisomy_type = [];
var trisomy_type_hash = {};
var trisomy_type_hash_keys = [];
var trisomy_type_hash_values = [];
var birthdate = [];
var age = [];
var piechart_data = [];

 
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
})





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
            text: '',
            align: 'high'
        },
        labels: {
            overflow: 'justify'
        }
    },
    tooltip: {
        valueSuffix: ' children'
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
        name: 'Children by Trisomy Type',
        data: trisomy_type_hash_values
    }]
});
});

var trisomy_types_piechart_keys = [];
var trisomy_types_values = []

// for (i = 0; i < 5; i++) {
//     text += "The number is " + i + "<br>";
// }

$.getJSON('/api/v1/children/trisomy_type_totals', function(data) {
    var json = data; 

    Highcharts.chart('container2', {
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: ''
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    }
                }
            }
        },


    series: 

    [{
        name: 'Trisomy Type of Registered Children',
        colorByPoint: true,
        data: json





    }]
}); 
}); 







