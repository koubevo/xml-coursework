<?php

declare(strict_types=1);
function sanitize_input(string $input): string
{
    return htmlspecialchars(trim($input), ENT_QUOTES, 'UTF-8');
}

$days = ['pondeli', 'utery', 'streda', 'ctvrtek', 'patek', 'sobota', 'nedele'];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = [];

    $fields = [
        'nazev',
        'popis',
        'majitel',
        'mesto',
        'stat',
        'menu',
        'slovni',
        'misto',
        'obsluha',
        'jidlo',
        'finalni',
        'top_jidlo_nazev',
        'top_jidlo_cena',
        'top_jidlo_mena',
        'top_jidlo_foto',
        'cena_osoba',
        'cena_osoba_mena',
        'platba_kartou',
    ];

    $data['kategorie'] = explode(',', htmlspecialchars(trim($_POST['kategorie']), ENT_QUOTES, 'UTF-8'));

    foreach ($fields as $field) {
        $data[$field] = sanitize_input($_POST[$field] ?? '');
    }

    $oteviraciDoba = [];
    foreach ($days as $day) {
        $oteviraciDoba[$day] = [
            'od' => sanitize_input($_POST["{$day}_od"] ?? ''),
            'do' => sanitize_input($_POST["{$day}_do"] ?? ''),
        ];
    }

    $data['oteviraci_doba'] = $oteviraciDoba;

    echo '<pre>';
    print_r($data);
    echo '</pre>';

    //vygenerovat id ktery neni v dokumentu
}

?>