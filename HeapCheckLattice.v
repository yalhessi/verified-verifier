Require Import Lattice.

Inductive YesOrBottom : Set :=
| yes
| bottom.

Inductive YOBRel : YesOrBottom -> YesOrBottom -> Prop :=
| bot_rel x : YOBRel bottom x
| top_rel t : YOBRel t t.

Program Instance YOBOrder : Order YesOrBottom := { ord := YOBRel }.
Next Obligation.
  unfold RelationClasses.Reflexive.
  apply top_rel.
Defined.
Next Obligation. Proof.
  induction x; induction y; auto.
  inversion H. inversion H0.
Defined.
Next Obligation. Proof.
  unfold RelationClasses.Transitive.
  induction x; induction y; induction z; auto; intros.
  - apply top_rel.
  - apply top_rel.
Defined.

Definition meetYOB (a:YesOrBottom) (b:YesOrBottom) : YesOrBottom :=
  match a with
  | yes => b
  | bottom => bottom
  end.

Definition joinYOB (a:YesOrBottom) (b:YesOrBottom) : YesOrBottom :=
  match a with
  | bottom => b
  | yes => yes
  end.

Program Instance YOBLattice : Lattice YesOrBottom :=
  {
    meet := meetYOB;
    join := joinYOB

    (*meet_commutative : forall a b, a ⊓ b = b ⊓ a;
    meet_associative : forall a b c, (a ⊓ b) ⊓ c = a ⊓ (b ⊓ c);
    meet_absorptive  : forall a b, a ⊓ (a ⊔ b) = a;
    meet_idempotent  : forall a, a ⊓ a = a;

    join_commutative : forall a b, a ⊔ b = b ⊔ a;
    join_associative : forall a b c, (a ⊔ b) ⊔ c = a ⊔ (b ⊔ c);
    join_absorptive  : forall a b, a ⊔ (a ⊓ b) = a;
    join_idempotent  : forall a, a ⊔ a = a*)
  }.
Next Obligation.
  unfold meetYOB; induction a; induction b; auto.
Defined.
Next Obligation. Proof.
  unfold meetYOB; induction a; induction b; induction c; auto.
Defined.
Next Obligation. Proof.
  unfold meetYOB; unfold joinYOB; induction a; auto.
Defined.
Next Obligation. Proof.
  unfold meetYOB; induction a; auto.
Defined.
Next Obligation. Proof.
  unfold joinYOB; induction a; induction b; auto.
Defined.
Next Obligation. Proof.
  unfold joinYOB; induction a; induction b; induction c; auto.
Defined.
Next Obligation. Proof.
  unfold joinYOB; unfold meetYOB; induction a; auto.
Defined.
Next Obligation. Proof.
  unfold joinYOB; induction a; auto.
Defined.

Program Instance YOBLOSet : LOSet YOBOrder YOBLattice.
Next Obligation.
  split.
  - intros. unfold meetYOB. induction a; induction b; auto.
    inversion H.
  - intros. induction a; induction b; auto.
    constructor. inversion H. constructor. constructor.
Defined.
Next Obligation. Proof.
  split.
  - intros. induction a; induction b; auto.
    inversion H.
  - intros. induction a; induction b; auto.
    constructor. inversion H. constructor. constructor.
Defined.

Record HeapCheckAbstrState := {
  holdHeapBase     : YesOrBottom;
  bounded4GB       : YesOrBottom;
  HoldMysteryTable : YesOrBottom;
  HoldFnTableMd    : YesOrBottom;
  HoldFnPtrTable   : YesOrBottom;
}.
