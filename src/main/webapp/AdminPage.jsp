<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" type = "text/css" href = "./style.css"/>
<link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />

    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap"
      rel="stylesheet"
    />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Lora:ital,wght@0,400..700;1,400..700&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap"
      rel="stylesheet"
    />
    
    
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="styles.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="mb-4 text-center">Admin Dashboard</h1>
        <div class="row">
            <!-- Total Assigned Mobile Devices -->
            <div class="col-md-6">
                <div class="card dashboard-section">
                    <div class="card-body">
                        <h5 class="card-title">Total Assigned Mobile Devices</h5>
                        <p id="totalAssignedDevices" class="card-text display-6">Loading...</p>
                    </div>
                </div>
            </div>
            
            <!-- Total Available Mobile Devices -->
            <div class="col-md-6">
                <div class="card dashboard-section">
                    <div class="card-body">
                        <h5 class="card-title">Total Available Mobile Devices</h5>
                        <p id="totalAvailableDevices" class="card-text display-6">Loading...</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-4">
            <!-- Set Latest Patch Version -->
            <div class="col-md-12">
                <div class="card dashboard-section">
                    <div class="card-body">
                        <h5 class="card-title">Set Latest Patch Version</h5>
                        <form id="patchForm" action="setPatchVersion" method="post">
                            <div class="mb-3">
                                <label for="patchVersion" class="form-label">Latest Patch Version</label>
                                <input type="text" class="form-control" id="patchVersion" name="patchVersion" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Update Patch Version</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-4">
            <!-- Assigned Devices Table -->
            <div class="col-md-12">
                <div class="card dashboard-section">
                    <div class="card-body">
                        <h5 class="card-title">Assigned Devices</h5>
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Device ID</th>
                                    <th>Employee ID</th>
                                    <th>OS Version</th>
                                </tr>
                            </thead>
                            <tbody id="assignedDevicesTable">
                                <!-- Rows will be populated dynamically -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Fetch data from the server and populate the dashboard
        document.addEventListener('DOMContentLoaded', function() {
            fetch('getDashboardData')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('totalAssignedDevices').innerText = data.totalAssignedDevices;
                    document.getElementById('totalAvailableDevices').innerText = data.totalAvailableDevices;
                    populateAssignedDevicesTable(data.assignedDevices);
                });
        });

        function populateAssignedDevicesTable(devices) {
            const tableBody = document.getElementById('assignedDevicesTable');
            devices.forEach(device => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${device.deviceId}</td>
                    <td>${device.empId}</td>
                    <td>${device.osVersion}</td>
                `;
                tableBody.appendChild(row);
            });
        }
    </script>
</body>
</html>
