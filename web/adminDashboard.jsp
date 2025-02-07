<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Carbon Footprint Calculator</title>
  <link rel="stylesheet" href="style.css">
  <link rel="stylesheet" 
        href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" 
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" 
        crossorigin="anonymous">
  <link rel=
  "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"
        type="text/css" />
  <script src=
  "https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
  <script src=
  "https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js"
          type="text/javascript">
  </script>
  <script src=
  "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
  <script src=
  "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.2.2/Chart.min.js"></script>
</head>
<body>
  <header class="page-header">
    <h1>Real-Time Impact Tracker</h1>
    <p>Track real-time metrics on energy savings, waste reduction, and overall sustainability progress.</p>
  </header>

  <table>
    <tr>
        <th>

        </th>
        <th>
            
        </th>
    </tr>
  </table>

  <table class="table">
    <thead class="thead-dark">
      <tr>
        <th scope="col">No.</th>
        <th scope="col">Day</th>
        <th scope="col">Recyclable Waste</th>
        <th scope="col">Non-Recyclable Waste</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <th scope="row">1</th>
        <td>Monday</td>
        <td>9</td>
        <td>2</td>
      </tr>
      <tr>
        <th scope="row">2</th>
        <td>Tuesday</td>
        <td>7</td>
        <td>2</td>
      </tr>
      <tr>
        <th scope="row">3</th>
        <td>Wednesday</td>
        <td>4</td>
        <td>5</td>
      </tr>
      <tr>
        <th scope="row">4</th>
        <td>Thursday</td>
        <td>7</td>
        <td>5</td>
      </tr>
      <tr>
        <th scope="row">5</th>
        <td>Friday</td>
        <td>3</td>
        <td>2</td>
      </tr>
      <tr>
        <th scope="row">6</th>
        <td>Saturday</td>
        <td>2</td>
        <td>1</td>
      </tr>
      <tr>
        <th scope="row">7</th>
        <td>Sunday</td>
        <td>7</td>
        <td>10</td>
      </tr>
    </tbody>
  </table>
  

    <div class="container">
        <h2>Waste Produced</h2>
        <div>
            <canvas id="myChart"></canvas>
        </div>
    </div>
  </main>

  <footer class="page-footer">
    <p>© 2024 Sustainability Management System. All rights reserved.</p>
  </footer>

  <script src="script.js"></script>
</body>

<script>
    let ctx = document.getElementById("myChart").getContext("2d");
    let myChart = new Chart(ctx, {
        type: "line",
        data: {
            labels: [
                "Monday",
                "Tuesday",
                "Wednesday",
                "Thursday",
                "Friday",
                "Saturday",
                "Sunday",
            ],
            datasets: [
                {
                    label: "Recyclable Waste",
                    data: [9, 7, 4, 7, 3, 2, 7],
                    backgroundColor: "rgba(153,205,1,0.6)",
                },
                {
                    label: "Non-Recyclable Waste",
                    data: [2, 2, 5, 5, 2, 1, 10],
                    backgroundColor: "rgba(155,153,10,0.6)",
                },
            ],
        },
    });
</script>

</html>
