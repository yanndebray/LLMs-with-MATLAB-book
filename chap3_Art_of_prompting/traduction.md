# Comment exécuter des modèles DeepSeek locaux et les utiliser avec MATLAB

**Publié par Mike Croucher, le 4 février 2025**

**Vues :** 1079 (derniers 30 jours) | **J'aime :** 0 | **Commentaires :** 15

---

Après la sortie des modèles d'IA DeepSeek-R1, de nombreux utilisateurs se sont renseignés sur la manière de les utiliser dans MATLAB. Récemment, Vasileios Papanastasiou, ingénieur en test logiciel chez MathWorks, a partagé un guide sur LinkedIn, que j'ai suivi pour exécuter le modèle sur ma machine locale.

## Exécution de deepseek-r1:1.5b sur ma machine locale

Pour commencer, j'ai utilisé l'extension "Large Language Models (LLMS) with MATLAB" ainsi qu'Ollama pour exécuter l'un des modèles DeepSeek plus petits. Voici comment je l'ai fait :

1. **Télécharger et installer Ollama** : 
   - Visitez la [page de téléchargement d'Ollama](https://ollama.com/download) et installez-le sur votre machine Windows.

2. **Exécuter le modèle** : 
   - Après l'installation, ouvrez la ligne de commande et exécutez la commande :
     ```
     ollama run deepseek-r1:1.5b
     ```
   - Cette commande installe un modèle de 1,5 milliard de paramètres, qui est gérable en termes de ressources informatiques.

3. **Configurer MATLAB** : 
   - Au lieu de suivre le chemin GitHub de Vasileios, j'ai choisi d'utiliser MATLAB R2024b. J'ai cliqué sur **Add-ons** dans l'onglet Environnement, recherché 'Large Language Models', et cliqué sur 'Add' pour l'installer.

### Interagir avec le modèle dans MATLAB

Maintenant que l'installation est terminée, j'ai créé un objet `ollamaChat` dans MATLAB :

```matlab
chat = ollamaChat("deepseek-r1:1.5b")
```

Cette commande initialise l'objet de chat avec les propriétés suivantes :

- **ModelName** : "deepseek-r1:1.5b"
- **Endpoint** : "127.0.0.1:11434"
- **TopK** : Inf
- **MinP** : 0
- **TailFreeSamplingZ** : 1
- **Temperature** : 1
- **TopP** : 1
- **StopSequences** : [0×0 string]
- **TimeOut** : 120
- **SystemPrompt** : []
- **ResponseFormat** : "text"

### Génération de réponses

J'ai testé le modèle en lui posant une question :

```matlab
txt = generate(chat, "Quelle est la vitesse de la lumière ?")
```

La réponse était :

```
<think>
</think>
La valeur exacte de la vitesse de la lumière dans le vide est définie comme \( 299,792,458 \) mètres par seconde.
```

J'ai trouvé intéressant que les réponses du modèle variaient à chaque requête. Par exemple :

1. **Première requête** :
   ```
   La vitesse de la lumière dans le vide est d'environ 299,792 kilomètres (186,282 miles statutaires) par seconde.
   ```

2. **Deuxième requête** :
   ```
   <think>
   D'accord, j'essaie de comprendre quelle est la vitesse de la lumière...
   ...
   La vitesse de la lumière est d'environ trois fois 10^8 mètres par seconde mais est précisément calculée à environ 299,792,458 m/s.
   </think>
   ```

Le modèle a fourni une explication détaillée, montrant sa capacité à générer des réponses variées et complexes.

### Conclusion

Bien qu'il s'agisse d'une version plus petite du modèle DeepSeek, il démontre néanmoins des capacités utiles et constitue un moyen engageant d'explorer les forces et les faiblesses de la technologie IA basée sur les LLM. Je vous encourage à l'essayer et à partager vos réflexions !

---

Vous suivez maintenant cet article de blog et recevrez des mises à jour dans votre fil d'activité. Vous pouvez également recevoir des e-mails en fonction de vos préférences de notification.

**Catégorie** : Intelligence Artificielle (IA)