class Cart():
    def __init__(self, product_data):
        self.name = product_data['name']
        self.attributes = product_data['attributes']
        self.product_id = product_data['product_id']
        self.image = product_data['image']
        self.price = product_data['price']
        self.quantity = 0 
        self.sub_total = "0.00"


    def add_product_to_cart(self):
        self.quantity += 1
        self.sub_total = str(self.quantity * eval(self.price))
        