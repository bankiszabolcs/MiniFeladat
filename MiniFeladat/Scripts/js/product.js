
function showDeleteModal(productId, productName) {
    document.getElementById('hfProductId').value = productId
    document.querySelector('.modal-body').innerHTML = `Biztos vagy benne, hogy törlöd <strong>${productName}</strong>?`
}

function deleteItem() {
    const productId = document.getElementById('hfProductId').value;
    PageMethods.DeleteProduct(productId, onDeleteSuccess, onDeleteFailure);
}

function onDeleteSuccess(productId) {
    var deletedRow = document.getElementById('productRow_' + productId);
    if (deletedRow) {
        deletedRow.remove();
        openToast("Sikeres törlés!", "green")
    }
}

function onDeleteFailure(error) {
    console.error(error.get_message());
    openToast("Sikertelen törlés", "red")
}

function showEditModal(id = 0, name = "", price = 0, stockQuantity = 0, description = "", category = "", isAvailable = false) {

    document.getElementById('hfProductId').value = id;

    document.getElementById('editProductName').value = name;
    document.getElementById('editProductPrice').value = price;
    document.getElementById('editProductStockQuantity').value = stockQuantity;
    document.getElementById('editProductDescription').value = description;

    var categorySelect = document.getElementById('editProductCategory');
    if (category === "") {
        categorySelect.value = "-Kategóriák-";
    } else {
        categorySelect.value = category;
    }

    document.getElementById('editIsAvailable').checked = isAvailable;
}

function updateProduct() {

    const productId = document.getElementById('hfProductId').value;
    const name = document.getElementById('editProductName').value;
    const priceString = document.getElementById('editProductPrice').value;
    const price = parseFloat(priceString).toFixed(2);
    const stockQuantity = document.getElementById('editProductStockQuantity').value;
    const description = document.getElementById('editProductDescription').value;
    const category = document.getElementById('editProductCategory').value;
    const isAvailable = document.getElementById('editIsAvailable').checked;

    try {
        if (productId == 0) {
            PageMethods.AddProduct(name, price, stockQuantity, description, category, isAvailable, onUpdateSuccess, onUpdateFailure);
        } else {
            PageMethods.UpdateProduct(productId, name, price, stockQuantity, description, category, isAvailable, onUpdateSuccess, onUpdateFailure);
        }
    } catch (e) {
        console.log(e)
        openToast(`Sikertelen mentés. ${e}`, "red")
    }

}

function onUpdateSuccess(res) {
    if (!res.success) {
        openToast(res.message, "red")
        return
    }
    let product = res.data;
    var row = document.getElementById('productRow_' + product.ProductId);
    if (!row) {
        var tr = document.createElement("tr");
        tr.id = "productRow_" + product.ProductId;
        var tbody = document.querySelector("tbody");
        tbody.appendChild(tr);
        row = tr
    }
    row.innerHTML = "";
    row.innerHTML = `
            <td class="text-center align-middle">${product.ProductId}</td>
            <td class="text-center align-middle">${product.Name}</td>
            <td class="text-center align-middle">${product.Price} Ft</td>
            <td class="text-center align-middle">${product.StockQuantity} db</td>
            <td class="text-center align-middle">${product.Description}</td>
            <td class="text-center align-middle">${product.Category}</td>
             <td class="text-center text-muted align-middle">${product.IsAvailable ? '<i class="fa fa-check"></i>'
            :
            '<i class="fa fa-times"></i>'}</td>
            <td class="align-middle">
                <div class="d-flex justify-content-center column-gap-2">
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editModal" onclick="showEditModal(${product.ProductId}, '${product.Name}', ${product.Price}, ${product.StockQuantity}, '${product.Description}', '${product.Category}', ${(product.IsAvailable ? "true" : "false")})">
                        <i class="fa fa-edit"></i>
                    </button>
                    <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#deleteModal" onclick="showDeleteModal(${product.ProductId}, '${product.Name}')">
                        <i class="fa fa-trash"></i>
                    </button>
                </div>
            </td>;`

    openToast("Sikeres mentés", "green")


}

function onUpdateFailure(error) {
    console.error(error.get_message());
    openToast("Sikertelen mentés.", "red")
}

const checkNegativeOrNot = function () {
    var inputField = this.value;
    var min = 0;

    if (inputField.length === 0) {
        this.classList.add('is-invalid');
        this.nextElementSibling.innerText = "Mező nem lehet üres";
    }
    else if (inputField < min) {
        this.classList.add('is-invalid');
        this.nextElementSibling.innerText = "Az érték nem lehet negatív!";
    } else {
        this.classList.remove('is-invalid');
    }
}

const checkTheName = function () {
    const inputField = this.value;
    const min = 3;

    if (inputField.length === 0) {
        this.classList.add('is-invalid');
        this.nextElementSibling.innerText = "Mező nem lehet üres";
    }
    else if (inputField.length < min) {
        this.classList.add('is-invalid');
        this.nextElementSibling.innerText = "Névnek legalább 3 karakterből kell állnia";
    } else {
        this.classList.remove('is-invalid');
    }
}

const checkTheDescription = function () {
    var inputField = this.value;
    var min = 0;

    if (inputField.length === 0) {
        this.classList.add('is-invalid');
        this.nextElementSibling.innerText = "Mező nem lehet üres";
    } else {
        this.classList.remove('is-invalid');
    }
}

const checkTheCategory = function (e) {
    if (e.target.value === "-Kategóriák-") {
        this.classList.add('is-invalid');
    } else {
        this.classList.remove('is-invalid');
    }
}

document.querySelector('#editProductPrice').addEventListener('input', checkNegativeOrNot)
document.querySelector('#editProductStockQuantity').addEventListener('input', checkNegativeOrNot)
document.querySelector('#editProductName').addEventListener('input', checkTheName)
document.querySelector('#editProductDescription').addEventListener('input', checkTheDescription)
document.querySelector('#editProductCategory').addEventListener('click', checkTheCategory)
