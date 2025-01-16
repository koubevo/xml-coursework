<!DOCTYPE html>
<html lang="cs">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Přidání restaurace</title>
    <link rel="stylesheet" href="../transformations/output/sem_html.css">
</head>

<body>
    <div class="new">
        <h1 class="mb">Přidej novou restauraci</h1>
        <section>
            <form method="post" action="add_restaurant.php">
                <input type="text" placeholder="Název restaurace" name="nazev" required>
                <textarea name="popis" placeholder="Popis" required></textarea>
                <input type="text" placeholder="Majitel" name="majitel">
                <input type="text" placeholder="Město" name="mesto" required>
                <input type="text" placeholder="Stát" name="stat" required>
                <input type="url" placeholder="Menu (URL)" name="menu" required>
                <input type="text" placeholder="Kategorie (oddělit čárkou)" name="kategorie" required>

                <h2 class="my">Hodnocení</h2>
                <textarea name="slovni" placeholder="Hodnocení slovní" required></textarea>
                <input type="number" name="misto" step="0.1" placeholder="Místo" min="0" max="5" required>
                <input type="number" name="obsluha" step="0.1" placeholder="Obsluha" min="0" max="5" required>
                <input type="number" name="jidlo" step="0.1" placeholder="Jídlo" min="0" max="5" required>
                <input type="number" name="finalni" step="0.1" placeholder="Finální hodnocení" min="0" max="5" required>

                <h3 class="my">Nejlepší jídlo</h3>
                <input type="text" placeholder="Název jídla" name="top_jidlo_nazev" required>
                <section class="cena_mena">
                    <input type="number" placeholder="Cena jídla" name="top_jidlo_cena" required>
                    <select name="top_jidlo_mena" required>
                        <option value="CZK">CZK (Česká koruna)</option>
                        <option value="EUR">EUR (Euro)</option>
                        <option value="USD">USD (Americký dolar)</option>
                        <option value="GBP">GBP (Britská libra)</option>
                    </select>
                </section>
                <input type="text" placeholder="Název souboru fotky" name="top_jidlo_foto"
                    pattern="[\w,\s-]+\.(jpg|jpeg|png)" required>


                <h2 class="my">Otevírací doba</h2>
                <section class="otviracka">
                    <div class="den">
                        <label for="pondeli_od">Pondělí - Od:</label>
                        <input type="time" id="pondeli_od" name="pondeli_od" required>
                        <label for="pondeli_do">Do:</label>
                        <input type="time" id="pondeli_do" name="pondeli_do" required>
                    </div>
                    <div class="den">
                        <label for="utery_od">Úterý - Od:</label>
                        <input type="time" id="utery_od" name="utery_od" required>
                        <label for="utery_do">Do:</label>
                        <input type="time" id="utery_do" name="utery_do" required>
                    </div>
                    <div class="den">
                        <label for="streda_od">Středa - Od:</label>
                        <input type="time" id="streda_od" name="streda_od" required>
                        <label for="streda_do">Do:</label>
                        <input type="time" id="streda_do" name="streda_do" required>
                    </div>
                    <div class="den">
                        <label for="ctvrtek_od">Čtvrtek - Od:</label>
                        <input type="time" id="ctvrtek_od" name="ctvrtek_od" required>
                        <label for="ctvrtek_do">Do:</label>
                        <input type="time" id="ctvrtek_do" name="ctvrtek_do" required>
                    </div>
                    <div class="den">
                        <label for="patek_od">Pátek - Od:</label>
                        <input type="time" id="patek_od" name="patek_od" required>
                        <label for="patek_do">Do:</label>
                        <input type="time" id="patek_do" name="patek_do" required>
                    </div>
                    <div class="den">
                        <label for="sobota_od">Sobota - Od:</label>
                        <input type="time" id="sobota_od" name="sobota_od" required>
                        <label for="sobota_do">Do:</label>
                        <input type="time" id="sobota_do" name="sobota_do" required>
                    </div>
                    <div class="den">
                        <label for="sobota_od">Neděle - Od:</label>
                        <input type="time" id="nedele_od" name="nedele_od" required>
                        <label for="sobota_do">Do:</label>
                        <input type="time" id="nedele_do" name="nedele_do" required>
                    </div>
                </section>


                <h2 class="my">Další informace</h2>
                <section class="">
                    <section class="cena_mena">
                        <input type="number" placeholder="Cena/osoba" name="cena_osoba" required>
                        <select name="cena_osoba_mena" required>
                            <option value="CZK">CZK (Česká koruna)</option>
                            <option value="EUR">EUR (Euro)</option>
                            <option value="USD">USD (Americký dolar)</option>
                            <option value="GBP">GBP (Britská libra)</option>
                        </select>
                    </section>
                    <label for="karta" class="mb">Platba kartou</label>
                    <select name="platba_kartou" id="karta" required>
                        <option value="ano">Ano</option>
                        <option value="ne">Ne</option>
                        <option value="někdy">Někdy</option>
                    </select>
                    <label for="qerko" class="mb">Qerko</label>
                    <select name="qerko" id="qerko" required>
                        <option value="ano">Ano</option>
                        <option value="ne">Ne</option>
                    </select>
                    <label for="poledni_menu" class="mb">Polední menu</label>
                    <select name="poledni_menu" id="poledni_menu" required>
                        <option value="každý den">Každý den</option>
                        <option value="pracovní dny">Pracovní dny</option>
                        <option value="víkendy">Víkendy</option>
                        <option value="ne">Ne</option>
                    </select>
                </section>

                <label for="date" class="mb">Datum návštěvy</label>
                <input id="date" type="date" name="datum" placeholder="Datum návštěvy" required>
                <input type="submit" class="submit" value="Přidat restauraci">            </form>
        </section>
    </div>
</body>

</html>