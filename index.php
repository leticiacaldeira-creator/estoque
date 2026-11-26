<?php
require_once __DIR__ . '/includes/init.php';

$produtos = $pdo->query('SELECT * FROM produtos ORDER BY nome')->fetchAll();

require_once __DIR__ . '/includes/header.php';
?>

<h2>Essa é a página inicial</h2>

<?php if (!$produtos): ?>
    <p>Nenhum produto cadastrado. <a href="produto.php">Cadastre o primeiro</a>.</p>
<?php else: ?>
    <table>
        <tr>
            <th>Produto</th>
            <th>Preço</th>
            <th>Quantidade</th>
            <th>Mínimo</th>
            <th>Ações</th>
        </tr>
        <?php foreach ($produtos as $p): ?>
            <?php $baixo = $p['quantidade'] < $p['estoque_minimo']; ?>
            <tr class="<?= $baixo ? 'baixo' : '' ?>">
                <td><?= e($p['nome']) ?></td>
                <td>R$ <?= number_format((float) $p['preco'], 2, ',', '.') ?></td>
                <td><?= e($p['quantidade']) ?><?= $baixo ? ' (estoque baixo)' : '' ?></td>
                <td><?= e($p['estoque_minimo']) ?></td>
                <td class="acoes">
                    <a href="movimentar.php?id=<?= e($p['id']) ?>">Movimentar</a>
                    <a href="produto.php?id=<?= e($p['id']) ?>">Editar</a>
                    <form method="post" action="excluir.php"
                          onsubmit="return confirm('Excluir o produto e todo o histórico dele?')">
                        <?= campo_csrf() ?>
                        <input type="hidden" name="id" value="<?= e($p['id']) ?>">
                        <button type="submit" class="perigo">Excluir</button>
                    </form>
                </td>
            </tr>
        <?php endforeach; ?>
    </table>
<?php endif; ?>


<?php
require_once __DIR__ . '/includes/footer.php'
?>