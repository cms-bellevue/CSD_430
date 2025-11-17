/* 
Clint Scott
CSD 430
Module 5 Assignment
11/16/2025

This script provides client side table sorting for module5_read.jsp.
Columns can be sorted in ascending or descending order by clicking the headers.
*/

function sortTable(n) {
    var table = document.getElementById("moviesTable");
    var switching = true;
    var dir = "asc";
    var switchcount = 0;

    // Numeric columns ID and Year
    var numericCols = [0, 2];

    while (switching) {
        switching = false;
        var rows = table.rows;

        for (var i = 1; i < rows.length - 1; i++) {
            var shouldSwitch = false;

            var x = rows[i].getElementsByTagName("TD")[n];
            var y = rows[i + 1].getElementsByTagName("TD")[n];

            var xVal = x.innerText;
            var yVal = y.innerText;

            if (numericCols.includes(n)) {
                xVal = parseFloat(xVal);
                yVal = parseFloat(yVal);
            } else {
                xVal = xVal.toLowerCase();
                yVal = yVal.toLowerCase();
            }

            if (dir === "asc") {
                if (xVal > yVal) {
                    shouldSwitch = true;
                    break;
                }
            } else {
                if (xVal < yVal) {
                    shouldSwitch = true;
                    break;
                }
            }
        }

        if (shouldSwitch) {
            rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
            switching = true;
            switchcount++;
        } else {
            if (switchcount === 0 && dir === "asc") {
                dir = "desc";
                switching = true;
            }
        }
    }
}