# Comment exécuter des modèles DeepSeek locaux et les utiliser avec MATLAB

**Publié par Mike Croucher, le 4 février 2025**

**Vues :** 1079 (derniers 30 jours) | **J'aime :** 0 | **Commentaires :** 15

---

Après la sortie des modèles d'IA DeepSeek-R1, de nombreux utilisateurs ont été impatients d'apprendre comment les intégrer avec MATLAB. Récemment, Vasileios Papanastasiou, ingénieur de test logiciel chez MathWorks, a partagé un guide sur LinkedIn, que j'ai décidé d'essayer sur ma propre machine.

## Exécution de deepseek-r1:1.5b sur ma machine locale

Pour exécuter l'un des modèles DeepSeek plus petits localement et interagir avec lui dans MATLAB, j'ai utilisé l'extension "Large Language Models (LLMS) with MATLAB" ainsi qu'Ollama. Voici comment je l'ai configuré :

1. **Télécharger et installer Ollama** : 
   - Visitez la [page de téléchargement d'Ollama](https://ollama.com/download) et installez-le sur votre machine Windows.

2. **Exécuter le modèle** : 
   - Après l'installation, ouvrez la ligne de commande et exécutez la commande :
     ```
     ollama run deepseek-r1:1.5b
     ```
   - Cette commande installe un modèle de 1,5 milliard de paramètres, qui est gérable en termes de ressources informatiques.

3. **Configurer MATLAB** : 
   - Au lieu de suivre le chemin GitHub de Vasileios, j'ai choisi d'utiliser MATLAB R2024b. J'ai cliqué sur **Add-ons** dans l'onglet Environnement, recherché "Large Language Models" et cliqué sur **Add** pour l'installer.

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

J'ai commencé à interagir avec l'IA en posant des questions. Par exemple :

```matlab
txt = generate(chat, "Quelle est la vitesse de la lumière ?")
```

L'IA a répondu avec :

```
<think>
</think>
La valeur exacte de la vitesse de la lumière dans le vide est définie comme \( 299,792,458 \) mètres par seconde.
```

J'ai trouvé intéressant que les réponses du modèle variaient à chaque requête. Voici quelques exemples :

1. **Première réponse** :
   ```
   La vitesse de la lumière dans le vide est d'environ 299,792 kilomètres (186,282 miles statutaires) par seconde.
   ```

2. **Deuxième réponse** (plus détaillée) :
   ```
   <think>
   D'accord, j'essaie de comprendre quelle est la vitesse de la lumière...
   ...
   En résumé, la vitesse de la lumière reste une constante, ayant un impact significatif sur divers domaines de la physique et notre compréhension de l'univers.
   </think>
   ```

### Conclusion

Bien que le modèle DeepSeek que j'ai utilisé soit relativement petit, il fournit néanmoins des informations précieuses et démontre les capacités et les limites de la technologie IA basée sur les LLM. Je vous encourage à expérimenter avec et à partager vos réflexions !

---

**Catégorie** : Intelligence Artificielle (IA)