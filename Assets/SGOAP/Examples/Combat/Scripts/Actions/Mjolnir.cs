using System.Collections;
using UnityEngine;

namespace SGoap
{
    public class Mjolnir : BasicAction
    {
        public float Range = 5f;

        public override float CooldownTime => 2;
        public override float StaggerTime => 1.5f;

        public bool OutOfRange => AgentData.DistanceToTarget > Range;
        //public bool AttackIsDone => !AgentData.Animator.GetBool("Attacking") && !Cooldown.Active;

        public override bool PrePerform()
        {
            if (OutOfRange)
                return false;

            AgentData.Agent.transform.LookAt(AgentData.Target);
            AgentData.Animator.SetTrigger("Mjolnir");
            var mjolnir = Instantiate(Skills.instance.mjolnir, GameManager.instance.player.transform.position,
                Quaternion.Euler(new Vector3(90, 0, 0)));
            mjolnir.GetComponent<ParticleSystem>().Play();
            
            StartCoroutine(GiveDamage());
            IEnumerator GiveDamage()
            {
                yield return new WaitForSeconds(1f);
                Debug.Log("Distance: " +
                          Vector3.Distance(mjolnir.transform.position, GameManager.instance.player.transform.position));
                if(Vector3.Distance(mjolnir.transform.position,GameManager.instance.player.transform.position) < 1f)
                    GameManager.instance.player.GetComponent<CharacterStatusController>().TakeDamage();
            }

            return base.PrePerform();
        }

        // public override EActionStatus Perform()
        // {
        //     return AttackIsDone ? EActionStatus.Success : EActionStatus.Running;
        // }
    }
}