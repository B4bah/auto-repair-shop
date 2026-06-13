function handleSubmit() {
  document.getElementById('success-msg').style.display = 'block';
  setTimeout(() => {
    document.getElementById('success-msg').style.display = 'none';
  }, 4000);
}