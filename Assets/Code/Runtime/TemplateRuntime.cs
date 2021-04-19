using System.Collections.Generic;

using BrandonUtils.Standalone.Exceptions;

using Newtonsoft.Json;

using TMPro;

using UnityEngine;

using Random = System.Random;

namespace Code.Runtime {
    public class TemplateRuntime : MonoBehaviour {
        private TemplateSaveData TemplateSaveData;
        public  TextMeshProUGUI  DoshText;

        // Start is called before the first frame update
        void Awake() {
            TemplateSaveData = new TemplateSaveData();
            UpdateDoshDisplay();
        }

        // Update is called once per frame
        void Update() {
            if (Input.GetKeyDown(KeyCode.Space)) {
                AddRandomDosh();
            }
        }

        public void AddDosh(double amount) {
            if (TemplateSaveData == null) {
                throw new BrandonException("It's bad!");
            }

            TemplateSaveData.Dosh += amount;
            UpdateDoshDisplay();
        }

        public void AddRandomDosh() {
            AddDosh(new Random().Next(1, 100));
        }

        private void UpdateDoshDisplay() {
            var doshInfo = new Dictionary<string, double>() {
                {nameof(TemplateSaveData.Dosh), TemplateSaveData.Dosh}
            };
            var doshInfoString = JsonConvert.SerializeObject(doshInfo);

            if (!DoshText) {
                throw new BrandonException("how is doshtext 'falsy'?");
            }

            if (DoshText.text == null) {
                throw new BrandonException("how is doshtext.text null?");
            }

            DoshText.text = doshInfoString;
        }
    }
}
