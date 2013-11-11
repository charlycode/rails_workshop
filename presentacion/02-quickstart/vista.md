Links entre vistas
===

<pre><code class="language-html">
<!-- Archivo app/views/say/goodbye.html.erb -->
<h1>Adios</h1>
<p>Vuelve pronto</p>
</code></pre>

Y en la otra vista:
<pre><code class="language-html">
<!-- Archivo app/views/say/hello.html.erb -->
<h1>Hola desde Rails</h1>
<p>Hola, son las <%= @time %></p>
<p>Hora de decir <%= link_to "adios", say_goodbye_path %></p>
</code></pre>



Has creado tu primera app Rails
===
