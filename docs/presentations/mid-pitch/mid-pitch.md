---
marp: true
theme: gaia
style: |
    @import url('https://fonts.googleapis.com/css2?family=Fredoka:wght@400;700&family=Lexend:wght@300;400;600&family=VT323&display=swap');
    
    :root {
        --text: #F6F0D7;
        --text-muted: #bab89e;
        --primary: #99AD7A;
        --secondary: #546B41;
        --accent: #db9bb2;
        --accent-2: #F2C94C;
        --background: #6d7b5e;
        --background-2: #454e3a;

        --font-title: 'Fredoka', sans-serif;
        --font-body: 'Lexend', sans-serif;
        --font-pixel: 'VT323', monospace;
    }
    h1 {
        font-size: 50px;
        font-family: var(--font-title);
        color: var(--accent);
    }
    section.invert h1 {
        color: var(--primary);
    }
    h2 {
        font-size: 45px;
        font-family: var(--font-pixel);
        color: var(--accent);
    }
    section.invert h2 {
        color: var(--primary);
    }
    section {
        font-size: 30px;
        font-family: var(--font-body);
        background-color: var(--background);
        color: var(--text);
    }
    section.invert {
        background-color: var(--background-2);
    }
    pre {
        border-radius: .4em;
        background-color: var(--text);
    }
    pre code {
        color: var(--background);
    }
    section.invert pre code {
        color: var(--background-2);
    }
    code {
        border-radius: 0.3em;
    }
---
<style>
  @import 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css';
  img {
    background-color: transparent!important;
  }

</style>

<img src="..\..\..\assets\logo\banner\banner-alt.png" alt="Project Flowering banner" style="width: 100%; height: auto;">

&nbsp; <span style="color: var(--text-muted);">Guilherme Cunha</span>
&nbsp; <span style="color: var(--text-muted);">Diogo Ribeiro</span>
&nbsp; <span style="color: var(--text-muted);">Adriano Elias</span>

---
<!-- _class: invert -->
<center style="margin-bottom: 2.25em;">

# Aplicações de Computação Gráfica na construção de visuais estilizados, level design e jogabilidade para um jogo 3D
</center>

Explorar técnicas de computação para otimizar e desenvolver simulações físicas e efeitos visuais, que interagem com o ambiente <span style="color: var(--accent);">renderizado em tempo real</span>.

<div style="margin-bottom: 2.25em;"></div>

       A única matéria de computação gráfica oferecida no IME durante nossa graduação foi
                            Introdução a Computação Gráfica (MAC0420)

---
<center>

# <i class="fas fa-lightbulb"></i>&nbsp;&nbsp;Proposta
</center> 

<span style="color: var(--accent-2);">Jogo dividido em fases</span>, cada uma com um objetivo diferente, que desafia o jogador a explorar o ambiente e interagir com os elementos do cenário para avançar.

         Ao progredir, o jogador encontra novas ferramentas para passar por obstáculos

<img src="assets/character_concept.png" alt="Character concept" style="width: 900px; height: auto; margin-left: 3.6em; margin-top: 1em;">

---
<!-- _class: invert -->
<center>

# <i class="fas fa-cogs"></i>&nbsp;&nbsp;Habilidades e mecânicas
</center>  

<div style="text-align: center; display: flex; justify-content: center; align-items: center; padding: -5; margin: -10; margin-top: 1em;">

<div style="margin-right: 50px;">

## <i class="fas fa-person-snowboarding"></i></i>&nbsp;Deslizar
<img src="assets/sliding_screenshot.png" alt="Sliding screenshot" style="width: 250px; height: auto;">

</div>

<div style="margin-right: 50px;">

## <i class="fas fa-person-walking-dashed-line-arrow-right"></i>&nbsp;Empurrar
<img src="assets/pushing_screenshot.png" alt="Pushing screenshot" style="width: 250px; height: auto;">

</div>

<div>

## <i class="fa-solid fa-person-falling-burst"></i>&nbsp;Atordoar
<img src="assets/stunning_screenshot.png" alt="Stunning screenshot" style="width: 250px; height: auto;">
</div>

</div>

---
<center>

# <i class="fas fa-skull"></i>&nbsp;&nbsp;Inimigos
</center>  

<div style="text-align: center; display: flex; justify-content: center; align-items: center; padding: -5; margin: -10; margin-top: 1em;">

<div style="margin-right: 50px;">

## <i class="fas fa-bug"></i>&nbsp;Besouro
<img src="assets/bettle_model.png" alt="Bettle model" style="width: 250px; height: auto;">

</div>

<div style="margin-right: 50px;">

## <i class="fas fa-bugs"></i>&nbsp;Formiga
<img src="assets/ant_model.png" alt="Ant model" style="width: 250px; height: auto;">

</div>

<div>

## <i class="fas fa-bomb"></i>&nbsp;Tatu-Bolinha
<img src="assets/sow_bug_model.png" alt="Sow bug model" style="width: 250px; height: auto;">
</div>

</div>

---
<!-- _class: invert -->
![bg h:98%](assets/schedule.png)