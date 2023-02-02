using System.Collections;
using UnityEngine;

namespace SGoap
{
    public class Gungnir : BasicAction
    {
        public float Range = 5f;

        public override float CooldownTime => 10;
        public override float StaggerTime => 0.5f;

        public bool OutOfRange => AgentData.DistanceToTarget > Range;
        //public bool AttackIsDone => !AgentData.Animator.GetBool("Attacking") && !Cooldown.Active;

        public override bool PrePerform()
        {
            if (OutOfRange)
                return false;

            AgentData.Agent.transform.LookAt(AgentData.Target);
            AgentData.Animator.SetTrigger("Mjolnir");
            var gungnir = Instantiate(Skills.instance.gungnir, GameManager.instance.player.transform.position,
                Quaternion.Euler(new Vector3(0, 0, 0)));
            Destroy(gungnir,3f);
            gungnir.GetComponent<ParticleSystem>().Play();
            
            StartCoroutine(GiveDamage());
            IEnumerator GiveDamage()
            {
                yield return new WaitForSeconds(0.2f);
                Debug.Log("Distance: " +
                          Vector3.Distance(gungnir.transform.position, GameManager.instance.player.transform.position));
                if(Vector3.Distance(gungnir.transform.position,GameManager.instance.player.transform.position) < 1f)
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