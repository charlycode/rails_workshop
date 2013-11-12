Nuestra app
===

Facturas: sistema de creación y administración de comprobantes fiscales.



Creación del proyecto
===

<pre><code data-trim>
#verifica que estés usando jruby
ruby -v
rails new facturas
cd facturas
bundle install
</code></pre>



Configuramos para que siempre use jruby
===

<pre><code data-trim>
#Modificar archivo Gemfile

source 'https://rubygems.org'

ruby '1.9.4', :engine => 'jruby', :engine_version => '1.7.6'
</code></pre>

Note:
- Importante para que todos los developers usen la misma versión.
- Importante para que el servidor de deployment sepa que versión usar.



Scaffolding
===

![Scaffolding](img/scaffolding.jpg)