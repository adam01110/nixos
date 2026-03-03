_: _final: prev:

# Backport `python3Packages.textstat` fix from nixpkgs PR 496030.
{
  python3Packages = prev.python3Packages.overrideScope (_pyFinal: pyPrev: {
    textstat = pyPrev.textstat.overridePythonAttrs (_old: {
      version = "0.7.13";

      src = prev.fetchFromGitHub {
        owner = "textstat";
        repo = "textstat";
        tag = "0.7.13";
        hash = "sha256-VMWwhwyGMFaKNLHoDG3gw1/jzSYCDBH3Yq4pE4JZTTo=";
      };

      dependencies = with pyPrev; [
        setuptools
        pyphen
        nltk
      ];

      NLTK_DATA = pyPrev.nltk.data.cmudict;
    });
  });
}
