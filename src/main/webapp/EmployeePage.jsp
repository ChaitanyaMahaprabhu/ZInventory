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
    <title>Employee Dashboard</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="styles.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="mb-4 text-center">Employee Dashboard</h1>

        <div class="row">
            <!-- Device Info Table -->
            <div class="col-md-12">
                <div class="card dashboard-section">
                    <div class="card-body">
                        <h5 class="card-title">Assigned Device</h5>
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Employee ID</th>
                                    <th>Device ID</th>
                                    <th>OS Version</th>
                                    <th>Apps</th>
                                </tr>
                            </thead>
                            <tbody id="deviceInfoTable">
                                <!-- Rows will be populated dynamically -->
                            </tbody>
                        </table>
                        <div id="osStatusMessage" class="alert mt-3" role="alert">
                            Loading OS version status...
                        </div>
                        <button id="updateVersionButton" class="btn btn-primary mt-3">Update Version</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-4">
            <!-- Email to Admin Section -->
            <div class="col-md-12">
                <div class="card dashboard-section">
                    <div class="card-body">
                        <h5 class="card-title">Contact Admin</h5>
                        <form id="emailForm" action="sendEmailToAdmin" method="post">
                            <div class="mb-3">
                                <label for="emailSubject" class="form-label">Subject</label>
                                <input type="text" class="form-control" id="emailSubject" name="subject" required>
                            </div>
                            <div class="mb-3">
                                <label for="emailBody" class="form-label">Message</label>
                                <textarea class="form-control" id="emailBody" name="message" rows="4" required></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">Send Email</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Fetch data from the server and populate the dashboard
        document.addEventListener('DOMContentLoaded', function() {
            fetch('getEmployeeDeviceInfo')
                .then(response => response.json())
                .then(data => {
                    populateDeviceInfoTable(data.deviceInfo);
                    checkOSVersion(data.deviceInfo, data.latestPatchVersion);
                });
        });

        function populateDeviceInfoTable(deviceInfo) {
            const tableBody = document.getElementById('deviceInfoTable');
            deviceInfo.forEach(device => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${device.empId}</td>
                    <td>${device.deviceId}</td>
                    <td>${device.osVersion}</td>
                    <td>${device.apps.join(', ')}</td>
                `;
                tableBody.appendChild(row);
            });
        }

        function checkOSVersion(deviceInfo, latestPatchVersion) {
            const osStatusMessage = document.getElementById('osStatusMessage');
            const updateVersionButton = document.getElementById('updateVersionButton');
            
            let outOfSync = false;
            deviceInfo.forEach(device => {
                if (device.osVersion !== latestPatchVersion) {
                    outOfSync = true;
                }
            });

            if (outOfSync) {
                osStatusMessage.classList.remove('alert-success');
                osStatusMessage.classList.add('alert-danger');
                osStatusMessage.innerText = 'OS version is out of sync with company guidelines.';
                updateVersionButton.disabled = false;
            } else {
                osStatusMessage.classList.remove('alert-danger');
                osStatusMessage.classList.add('alert-success');
                osStatusMessage.innerText = 'OS version is in sync with company guidelines.';
                updateVersionButton.disabled = true;
            }
        }
    </script>
</body>
</html>