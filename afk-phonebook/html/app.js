function searchTable() {
  const input = document.getElementById("searchInput");
  const filter = input.value.toUpperCase();
  const table = document.getElementById("phoneBookTable");
  const rows = table.getElementsByTagName("tr");
  for (let i = 0; i < rows.length; i++) {
    // Check if the row being processed is the header row
    if (rows[i].getElementsByTagName("th").length > 0) {
      continue;
    }
    const cols = rows[i].getElementsByTagName("td");
    let visible = false;
    for (let j = 0; j < cols.length; j++) {
      const data = cols[j].innerText.toUpperCase();
      if (data.toUpperCase().indexOf(filter) > -1) {
        visible = true;
        break;
      }
    }
    rows[i].style.display = visible ? "" : "none";
  }
}


window.addEventListener('message', function (event) {
  const data = event.data;
  if (data.type === 'phoneBookdata') {
    const phoneBookTable = document.getElementById('phoneBookTable');
    const row = phoneBookTable.insertRow(-1);
    const playerNameCell = row.insertCell(0);
    const phoneNumberCell = row.insertCell(1);
    const jobCell = row.insertCell(2);
    const fieldCell = row.insertCell(3);
    playerNameCell.innerHTML = data.playerName;
    phoneNumberCell.innerHTML = data.phoneNumber;
    jobCell.innerHTML = data.job;
    fieldCell.innerHTML = data.field;
    // show the container element when phoneBookdata is received
    document.getElementById('container').style.display = 'block';
  } else if (data.type === 'close') {
    const phoneBookTable = document.getElementById('phoneBookTable');
    while (phoneBookTable.firstChild) {
      phoneBookTable.removeChild(phoneBookTable.firstChild);
    }
    // hide the container element when close is received
    document.getElementById('container').style.display = 'none';
  }
});

document.getElementById('closeButton').addEventListener('click', function() {
  // Send a message to the server to close the NUI window
  axios.post('https://' + GetParentResourceName() + '/closeNUI', JSON.stringify({}));
  // Also close the NUI window on the client side
  const phoneBookTable = document.getElementById('phoneBookTable');
  while (phoneBookTable.firstChild) {
    phoneBookTable.removeChild(phoneBookTable.firstChild);
  }
  // hide the container element when close button is clicked
  document.getElementById('container').style.display = 'none';
});