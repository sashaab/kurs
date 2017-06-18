if (u1 = User.find_by_email('admin@localhost')).nil?
  u1 = User.create!(password: 'qwerty', password_confirmation: 'qwerty',
    email: 'admin@localhost')
  u1.activate!
end
if (u2 = User.find_by_email('user@localhost')).nil?
  u2 = User.create!(password: 'qwerty', password_confirmation: 'qwerty',
    email: 'user@localhost')
  u2.activate!
end
r1, r2 = Role.create_main_roles
ru1 = RoleUser.create(role: r1, user: u1)
ru2 = RoleUser.create(role: r2, user: u2)


#~ --------------------------------------- ТОВАРЫ --------------------------------------------------------------------------------------
p1 = Good.create!(title: 'Мяч', short_description: 'Шорт', full_description: 'Фул', list_id_images: 1,
base_price: 350, current_price: 450, quantity_in_stock: 120, article: 1, minimum_quantity: 1)

p2 = Good.create!(title: 'Шайба', short_description: 'Шорт', full_description: 'Фул', list_id_images: 2,
base_price: 50, current_price: 150, quantity_in_stock: 7, article: 2, minimum_quantity: 4)

p3 = Good.create!(title: 'Футболка', short_description: 'Шорт', full_description: 'Фул ', list_id_images: 3,
base_price: 1000, current_price: 1100, quantity_in_stock: 3, article: 3, minimum_quantity: 3)

#~ -------------------------------------------- КЛИЕНТЫ ---------------------------------------------------------------------------------
c1 = Client.create!(name: 'Sasha', phone: '+7', address: 'Moscow', email: "1@.com")

c2 = Client.create!(name: 'Rus',   phone: '+8', address: 'Russia', email: '2@.com')

c3 = Client.create!(name: 'Fil',   phone: '+9', address: 'Russia', email: '3@.com')

#~ -------------------------------------------- ЗАКАЗЫ ---------------------------------------------------------------------------------
o1 = Order.create!(client: c1, order_number: 1, payment_method: 'Наличный расчет', delivery_method: 'Курьером',
list_products: 1, cost_goods: 5000, total_cost: 5050, order_date: '2017-10-10')

o2 = Order.create!(client: c3, order_number: 2, payment_method: 'Наличный расчет', delivery_method: 'Курьером',
list_products: 2, cost_goods: 100, total_cost: 200, order_date: '2017-10-10')

#~ ---------------------------------------------- СПИСКИ -------------------------------------------------------------------------------
l1 = GoodOrder.create!(good: p1, order: o2, digit: 2)

l2 = GoodOrder.create!(good: p2, order: o1, digit: 2)
