module SideBarHelper
  def side_bar_items(ru)
    result = []
    result << {
      :name => 'На главную',
      :icon => 'list',
      :controller => :welcome,
      :action => :index
    }
    result << {
      :name => 'Меню',
      :icon => 'users',
      :children => [
      {:name => 'Клиенты',
       :controller => :clients, :action => :index,
       :icon => 'users',
       :class => 'long'},
      {:name => 'Товары',
       :controller => :goods, :action => :index,
       :icon => 'shopping-cart',
       :class => 'long'},
      {:name => 'Заказы',
       :controller => :orders, :action => :index,
       :icon => 'shopping-cart',
       :class => 'long'},
      {:name => 'Лист заказов',
       :controller => :good_orders, :action => :index,
       :icon => 'shopping-cart',
       :class => 'long'},
    ]}
    result << {
      :name => 'Администрирование',
      :icon => 'users',
      :children => [
      {:name => 'Пользователи',
       :controller => :users, :action => :index,
       :icon => 'users',
       :class => 'long'},
      {:name => 'Добавление',
       :controller => :users, :action => :new,
       :icon => 'user-plus'},
      {:name => 'Роли',
       :controller => :roles, :action => :index,
       :icon => 'align-center',
       :class => 'long'},
    ]} if ru.try(:is_admin?)
    result << {
      :name => 'Заказы',
      :icon => 'shopping-cart',
      :children => [
      {:name => 'Поиск',
       :controller => :orders, :action => :search,
       :icon => 'drivers-license',
       :class => 'long'},

    ]} if (ru.try(:is_admin?) or ru.try(:is_operator?))
    result
  end

  def is_open?(ctr, act)
    case ctr.to_s
    when 'users', 'roles', 'clients', 'orders', 'good_orders', 'goods'
      ctr.to_s == controller_name.to_s
    else
      false
    end
  end
end
