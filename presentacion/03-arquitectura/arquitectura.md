Arquitectura de una app Rails
===



MVC
===
![MVC](img/rails_arq.jpg)



ActiveRecord
===

Capa ORM (Object Relational Mapping de Rails).

Mapea tablas a clases, filas a objetos y columnas a atributos

<pre><code data-trim>
require ​'active_record'​
​ 	
​class​ Order < ActiveRecord::Base
​ 	
​end​
​ 	 	
order = Order.find(1)
​order.pay_type = ​"Purchase order"​
​order.save
</code></pre>



Action Pack: Vistas
===

- Sistema de templates, por defecto usa ERb, pero puede cambiarse.
- Soporte para javascript y coffeescript.
- Assets pipeline (optmización de assets).



Action Pack: Controladores
===

- Ruteo de peticiones a controladores.
- Cache.
- Sesiones.
- ActionController: clase base.



Rack
===

Rack es la librería (gema) que integra una aplicación Ruby con un servidor Web.

A partir de Rails 3, se hace esta separación haciendo posible crear apps web con 
Ruby sin la necesidad de usar todo Rails.

La configuración de Rack la puedes encontrar en el archivo <strong>config.ru</strong>



Filosofía
===

- Gratificación instantánea.
- DRY: Don't Repeat Yourself.
- Convention over configuration.