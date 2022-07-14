<a id="recipes-list-top"></a>
<ul class="recipes-list">
<?php foreach (scandir($_SERVER['DOCUMENT_ROOT'].'/recipes') as $file): ?>
	<?php if (preg_match('/^[a-z].*\.(php|html)/i', $file)): ?>
	<?=
		"<li><a href='/recipes/".$file."'>"
		.ucfirst(preg_replace('/\.(php|html)$/', '', $file))
		."</a></li>"
	?>
	<?php endif; ?>
<?php endforeach; ?>
</ul>
