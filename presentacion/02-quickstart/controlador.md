02 - Controlador
===

<pre><code data-trim>
rails generate controller Say hello goodbye
</code></pre>
![Quickstart Controllers](img/quickstart02.png)



En tu browser
===

http://localhost:3000/say/hello



Si te sale este error
===
![JCE Error](img/quickstart03.jpg)



Descarga JCE policy
http://www.oracle.com/technetwork/java/javase/downloads/jce-7-download-432124.html

Reemplaza los tuyos en la carpeta
<pre><code data-trim>
JAVA_HOME/jre/lib/security 
</code></pre>
<br/>
Por ejemplo en:
<pre><code data-trim>
/Library/Java/JavaVirtualMachines/jdk1.7.0_25.jdk/Contents/Home/jre/lib/security 
</code></pre>



Funciona
===
![JCE Error](img/quickstart04.jpg)



El controlador
====

<pre><code data-trim>
#Archivo app/controllers/say_controller.rb	
class SayController < ApplicationController
  def hello
  	#agrega
  	@time = Time.now
  end

  def goodbye
  end
end
</code></pre>



La vista
====

<pre><code class="language-html">
<!-- Archivo app/views/say/hello.html.erb -->
<h1>Hola desde Rails</h1>
<p>Hola, son las <%= @time %></p>
</code></pre>



Recarga tu browser
===
![Vista](img/quickstart05.jpg)	