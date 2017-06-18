module GoodOrdersHelper
  def link_to_add_good(form, order)
    new_object = GoodOrder.new()
    fields = form.fields_for(:good_orders, new_object,
      :child_index => 'new_good') do |lf|
      render('orders/one_good_order_form', lf: lf, i: 'Новая')
    end
    # Ссылка будет обрабатываться javascript-ом поэтому адрес фиктивный
    link_to(?#, class: 'btn btn-info',
        id: 'add_good_link', data: {content: "#{fields}"}) do
      fa_icon("plus") + " Новый товар"
    end
  end

  def link_to_remove_good(form)
    form.hidden_field(:_destroy, class: 'remove_fields') +
        link_to(?#, class: 'remove_fields remove_good') do
      fa_icon('times', title: 'Удалить товар') + ' Удалить'
    end
  end
end
