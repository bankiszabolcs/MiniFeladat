function openToast(text, color) {

    let toastEl = document.querySelector('.toast');
    let toastBody = toastEl.querySelector('.toast-body')

    toastBody.innerText = text;

    if (color === "red") {
        toastEl.classList.add('bg-danger')
        toastEl.classList.remove('bg-success')
    } else if (color === "green") {
        toastEl.classList.remove('bg-danger')
        toastEl.classList.add('bg-success')
    }

    let toast = new bootstrap.Toast(toastEl);

    toast.show();

    setTimeout(function () {
        toast.hide();
    }, 2000);
}